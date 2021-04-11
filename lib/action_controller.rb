require_relative './action.rb'

class ActionController
  def deadend
    nil
  end

  def reply_to(action, params, channel)
    Action.new(action, params, channel)
  end

  def broadcast(action, params, channels)
    channels.map do |channel|
      reply_to(action, params, channel)
    end
  end
end
