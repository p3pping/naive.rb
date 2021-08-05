require_relative '../../lib/naive'

module Examples
  module Chat
    class Server
      def initialize(controller)
        @socket = Naive::UDPSocket.new
        @socket.bind('127.0.0.1', 9002)

        @sender = Naive::Sender.new(@socket)
        @listener = Naive::Listener.new(@socket)
        @caller = Naive::Caller.new(controller)
      end

      def pump
        [*@caller.call(@listener.listen)].compact.each do |action|
          puts action
          @sender.send(action)
        end
      end
    end
  end
end
