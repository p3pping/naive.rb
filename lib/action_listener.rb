require_relative './action'
require_relative 'udp_packet'

class ActionListener
  MAX_ACTION_SIZE = 512

  def initialize(socket)
    @socket = socket
  end

  def listen
    Action.from_packet(
      UDPPacket.new(
        @socket.recvfrom(MAX_ACTION_SIZE)
      )
    )
  end
end
