class UDPPacket
  attr_reader :data, :family, :port, :host, :resolved_host

  def initialize(packet)
    @data = packet[0]
    @family = packet[1][0]
    @port = packet[1][1]
    @resolved_host = packet[1][2]
    @host = packet[1][3]
  end
end
