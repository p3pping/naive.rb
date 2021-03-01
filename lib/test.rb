require 'socket'
require_relative './action_listener'
require_relative './action_caller'

class TestController
  def hello(to)
    print("HELLO THERE #{to}")
  end
end

s = UDPSocket.new
s.bind('127.0.0.1', 9001)

l = ActionListener.new(s)
c = ActionCaller.new(TestController.new)
c.call(l.listen)

