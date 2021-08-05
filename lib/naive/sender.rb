require_relative './action_parser'

module Naive
  class Sender
    def initialize(socket)
      @socket = socket
    end

    def send(action)
      @socket.send(
        ActionParser.to_s(action),
        0,
        action.channel.host,
        action.channel.port
      )
    end
  end
end
