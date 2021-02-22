require 'socket'
require 'json'

class ActionListener
  MAX_PACKET_SIZE = 255

  def initialize(socket, controller)
    @socket = socket
    @controller = controller
  end

  def pump
    process_packet(@socket.recvfrom(MAX_PACKET_SIZE))
  end

  private

  def process_packet(packet)
    packet = JSON.parse(packet[0])
    return unless packet.key?('action')

    action = packet['action'].to_sym
    raise "Action not found (#{action}) on controller: #{@controller}." unless @controller.methods.include?(action)

    @controller.method(action).call(action_params(packet))
  end

  def format_action(action, params)
    { 'action': action }.merge(params).to_json
  end

  def action_params(packet)
    packet.dup.tap do |params|
      params.delete(:action)
    end
  end
end

