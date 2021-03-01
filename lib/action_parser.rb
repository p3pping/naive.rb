require 'json'

class ActionParser
  def self.parse(action_string)
    JSON.parse(action_string)
  end
  
  def self.to_s(action)
    {
      action: action.name,
      params: action.params
    }.to_json
  end
end

