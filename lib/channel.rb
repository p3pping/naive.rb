class Channel
  attr_reader :host, :port

  def initialize(host, port)
    @host, @port = host, port
  end
end
