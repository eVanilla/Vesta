#
# Client class
#

require 'faraday'

class Client
  def self.communicate(host, port, peers)
    begin
      Faraday.post("#{host}:#{port}/communicate", peers: peers).body
    rescue Faraday::ConnectionFailed => e
      raise
    end
  end

  def self.get_public_key(host,port)
    Faraday.post("#{host}:#{port}/get_pubkey").body
  end

  def self.send_message(host,port,from,message)
    begin
      Faraday.post("#{host}:#{port}/get_message", from: from, message: message).body
    rescue Faraday::ConnectionFailed => e
      raise
    end
  end
  
end