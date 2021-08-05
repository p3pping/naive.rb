require_relative '../../lib/naive'

module Examples
  module Chat
    class ServerController < Naive::Controller
      def initialize
        super
        @channels = {}
      end

      def new_user(params, channel:)
        puts 'New User'
        puts params
        @channels[params] ||= channel

        deadend
      end

      def new_message(params, channel:)
        puts 'New Message:'
        puts params

        broadcast('new_message', forwarded_message(params, find_user_by_channel(channel)), @channels.values)
      end

      private

      def forwarded_message(body, from)
        "#{from} : #{body}"
      end

      def find_user_by_channel(channel)
        @channels.select do |_key, value|
          value.host == channel.host && value.port == channel.port
        end.keys.first
      end
    end
  end
end
