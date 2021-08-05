require_relative './client'
require_relative './client_controller'

require_relative './server'
require_relative './server_controller'

module Examples
  module Chat
    def self.start_client
      client = Client.new

      while true do
        client.pump
      end
    end

    def self.start_server
      server = Server.new(ServerController.new)

      while true do
        server.pump
      end
    end
  end
end
