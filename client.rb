require 'socket'
require 'json'
require_relative 'action_listener'

class Client
  MAX_PACKET_SIZE = 255

  def initialize(controller)
    @socket = new_client_socket
    @controller = controller
    @listener = ActionListener.new(@socket, @controller)
  end

  def connect(host, port)
    @server_host = host
    @server_port = port
  end

  def pump
    @listener.pump
  end

  def send(action, params)
    @socket.send(format_action(action, params), 0, @server_host, @server_port)
  end

  private

  def format_action(action, params)
    { 'action': action }.merge(params).to_json
  end

  def new_client_socket
    UDPSocket.new.tap do |socket|
      socket.bind('127.0.0.1', random_port)
    end
  end

  def random_port
    max_port = 65535
    min_port = 49512
    random = Random.new
    ((random.rand * (max_port - min_port)) + min_port).to_i
  end
end

