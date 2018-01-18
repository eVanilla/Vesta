#
# Helpers
#
module Vesta
    class Helpers

        Thread.abort_on_exception = true

        # Print banner
        def self.banner
            "\t\tRunning Vesta v#{Vesta::VERSION}"
        end

        # Do something in every x seconds
        def every(seconds)
            Thread.new do
                loop do
                    sleep seconds
                    yield
                end
            end
        end

        # Root folder
        def self.root
            "#{File.expand_path( File.dirname(File.dirname(File.dirname(__FILE__))) )}"
        end
        
        # Add peer to peer object [peers_object]
        def add_peer(peer,host,port,public_key) 
            peer.push({host: host, port: port, public_key: public_key})
            peer
        end

        # Add message to [messages_object]
        def add_message(messages_object, from, message)
            messages_object.push({from: from, message: message})
            messages_object
        end

        # Print out the status
        def render_state
            puts "Node is running on " + Service::LHOST.to_s.magenta + ':'.colorize(:background => :white, :color => :magenta).bold + Service::LPORT.to_s.magenta.bold
            print "My Peers: ".upcase
            $PEERS.each do |peer|
                print "#{peer[:host]}:#{peer[:port]}".yellow.bold + ', '
            end
        end

        # Communicate with peers 
        def communicate(index,host,port)
            communicate_response = Client.communicate(host, port, YAML.dump($PEERS))
            parsed_response = YAML.load(communicate_response)
            new_peer = parsed_response['peers']
            update_peers(new_peer)
        rescue Faraday::ConnectionFailed
            $PEERS.delete_at(index)
        end

        # Update peers
        def update_peers(new_peers)
          # if !new_peers.nil? # if new peers are not nil, then append them to $PEERS
            $PEERS = $PEERS | new_peers
            $PEERS.uniq
          # end
        end
    end
end