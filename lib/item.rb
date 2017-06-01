require 'bigdecimal'
require 'time'

class Item

  attr_reader   :id,
                :merchant_id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(params = {})
    @id          = params["id"].to_i
    @merchant_id = params["merchant_id"].to_i
    @name        = params["name"]
    @description = params["description"]
    @unit_price  = BigDecimal.new(params["unit_price"], 4)
    @created_at  = Time.parse(params["created_at"])
    @updated_at  = Time.parse(params["updated_at"])
  end

end
