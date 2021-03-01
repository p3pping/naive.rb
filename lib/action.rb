require 'socket'
require_relative './action_parser'
require_relative './channel'

class Action
  def self.from_packet(packet)
    action_attributes = ActionParser.parse(packet.data)
    Action.new(
      action_attributes['action'].to_sym,
      action_attributes['params'],
      Channel.new(packet.host, packet.port)
    )
  end

  attr_reader :name, :params, :channel

  def initialize(name, params, channel)
    @name = name
    @params = params
    @channel = channel
  end
end

