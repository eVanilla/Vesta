require "vesta/client"
require "vesta/helpers"
require "vesta/version"

require 'sinatra/base'
require 'encryption'
require 'colorize'
require 'yaml'
require 'active_support/time'
require 'json'
require 'pp'

module Vesta
    class Service < Sinatra::Base
        # client = Client.new # initialzing client class
        helpers = Helpers.new # # initialzing helpers class

        LHOST, LPORT, PEER_HOST, PEER_PORT = ARGV.first(4)

        # Total peers 
        $PEERS = []
        $MESSAGES = []
        # Generate a 1024 bit private-key & public-key 
        $my_public_key, $my_private_key = Encryption::Keypair.generate( 1024 )

        # Adding local network to peers
        helpers.add_peer($PEERS, LHOST, LPORT, $my_public_key.to_s)
        # Checking options(a simple option parser) 
        if PEER_PORT.nil? || PEER_HOST.nil? # => if peer port and peer host were nil.. that means you're a node
            puts "Running node..".green.bold
        else
            # Adding peer to $PEERS
            $their_public_key = Client.get_public_key(PEER_HOST,PEER_PORT)
            helpers.add_peer($PEERS, PEER_HOST, PEER_PORT, $their_public_key)
        end

        # Sinatra configuration
        set :server, 'thin'
        set :connections, []
        set :port, LPORT
        set :public_folder, "#{Helpers.root}/lib/vesta/public"
        set :views, "#{Helpers.root}/lib/vesta/views"
        set :environment, :production

        # Communicate yield
        helpers.every(10.seconds) do
            # Communicate with peers in every x seconds
            $PEERS.each_with_index do |peer,index|
                host = peer[:host]
                port = peer[:port]
                # next if that peer is you
                next if LHOST == host && LPORT == port
                puts "communicating about peers #{host.to_s.green.bold}:#{port.to_s.green}"  
                helpers.communicate(index, host, port)
            end
            system 'clear'
            helpers.render_state
        end

        # Communication route
        post '/communicate' do
            their_peers = YAML.load(params['peers'])
            helpers.update_peers(their_peers)
            YAML.dump('peers' => $PEERS)
        end

        # Send message route
        post '/send_message' do
            $PEERS.each do |peer|
                next if peer[:host] == LHOST && peer[:port] == LPORT
                pub_key = Encryption::PublicKey.new(peer[:public_key])
                message = pub_key.encrypt(params['message'])
                puts "-- ENCRYPTED MESSAGE --".cyan.bold
                puts message.to_s[0..50] + " ..."
                puts "-- ENCRYPTED MESSAGE --".cyan.bold
                from = "#{LHOST}:#{LPORT}"
                Client.send_message(peer[:host],peer[:port], from, message)
            end
        end

        # Add my messages to $MESSAGES 
        post '/my_messages' do 
            encrypted_message = $my_public_key.encrypt(params['message']).to_s
            $MESSAGES = helpers.add_message($MESSAGES, "#{LHOST}:#{LPORT}", encrypted_message)
        end

        # Add messages to $MESSAGES
        post '/get_message' do
            puts "-- GOT A MESSAGE".cyan.bold
            $MESSAGES = helpers.add_message($MESSAGES, params['from'], params['message'])
        end

        # Return $MESSAGES to json output
        post '/get_messages' do
            messages = []
            $MESSAGES.each do |msg|
              messages << {from: msg[:from], message: $my_private_key.decrypt(msg[:message]).to_s.force_encoding('ASCII-8BIT').force_encoding('UTF-8')}
            end
            messages.to_json
        end

        # Share pub key
        post '/get_pubkey' do
            $my_public_key.to_s
        end

        # Return $PEERS length
        post '/total_peers' do
            $PEERS.size.to_s
        end

        # Index route
        get '/' do
            erb :index
        end

        # 404 not found route
        not_found do
            status 404
            erb :oops
        end
        run!
    end
end