#
# Client class
#

require 'faraday'

# module Vesta
    class Client

        # Communicating
        def self.communicate(host, port, peers)
            begin
                Faraday.post("#{host}:#{port}/communicate", peers: peers).body
            rescue Faraday::ConnectionFailed => e
                raise
            end
        end

        # Getting public key from connected peer
        def self.get_public_key(host,port)
            Faraday.post("#{host}:#{port}/get_pubkey").body
        end

        # Sending messages to peers
        def self.send_message(host,port,from,message)
            begin
                Faraday.post("#{host}:#{port}/get_message", from: from, message: message).body
            rescue Faraday::ConnectionFailed => e
                raise
            end
        end
        
    end
# end