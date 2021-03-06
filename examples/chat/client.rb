# Create an example chat client here
require_relative '../../lib/naive'

module Examples
  module Chat
    class Client
      def initialize(controller = nil)
        @server = Naive::Channel.new('127.0.0.1', 9002)
        @user = nil
        @socket = Naive::UDPSocket.new
        @socket.bind('127.0.0.1', random_port)

        @listener = Naive::Listener.new(@socket)
        @caller = Naive::Caller.new(self)
        @sender = Naive::Sender.new(@socket)
      end

      def pump
        set_username && return unless @user

        send_message
        @caller.call(@listener.listen)
      end

      def new_message(params, channel:)
        puts params
      end

      private

      def random_port
        ((rand * 100) + 9003).to_i
      end

      def set_username
        puts 'Choose a Username:'
        @user = gets.chomp
        @sender.send(Naive::Action.new('new_user', @user, @server))
      end

      def send_message
        puts 'Send a message:'
        message = gets.chomp
        @sender.send(Naive::Action.new('new_message', message, @server))
      end
    end
  end
end
