require 'socket'
require_relative './lib/action_listener'
require_relative './lib/action_caller'
require_relative './lib/action_sender'

class TestController
  def hello(to)
    print("HELLO THERE #{to}")
  end
end

class TestClient
  def initialize(controller)
    @socket = UDPSocket.new
    @socket.bind('127.0.0.1', 9001)

    @listener = ActionListener.new(@socket)
    @caller = ActionCaller.new(controller)
  end

  def pump
    @caller.call(@listener.listen)
  end
end

class TestServer
  def initialize
    @socket = UDPSocket.new
    @socket.bind('127.0.0.1', 9002)

    @sender = ActionSender.new(@socket)
  end

  def send
    @sender.send(Action.new('hello', 'TESTER', Channel.new('127.0.0.1', 9001)))
  end
end

client = TestClient.new(TestController.new)
server = TestServer.new

server.send
client.pump
