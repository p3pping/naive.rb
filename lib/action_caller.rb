class ActionCaller
  def initialize(controller)
    @controller = controller
  end

  def call(action)
    print(@controller)
    @controller.method(action.name).call(*action.params)
  end
end
