module Naive
  class Caller
    def initialize(controller)
      @controller = controller
    end

    def call(action)
      print(@controller)
      @controller.method(action.name).call(*action.params, channel: action.channel)
    end
  end
end
