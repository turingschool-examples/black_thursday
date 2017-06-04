require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(params = {}, parent = nil)
    @parent     = parent
    @id         = params["id"].to_i
    @first_name = params["first_name"]
    @last_name  = params["last_name"]
    @created_at = Time.parse(params["created_at"])
    @updated_at = Time.parse(params["updated_at"])

  end
end
