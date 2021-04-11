require_relative '../../lib/action_listener.rb'
require_relative '../../lib/action_caller.rb'
require_relative '../../lib/action_sender.rb'

module Examples
  module Chat
    class Server
      def initialize(controller)
        @socket = UDPSocket.new
        @socket.bind('127.0.0.1', 9002)

        @sender = ActionSender.new(@socket)
        @listener = ActionListener.new(@socket)
        @caller = ActionCaller.new(controller)
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
