class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  def initialize(params)
  @name = params[0]
  @description = params[1]
  @unit_price = params[2]
  @created_at = Time.now
  @updated_at = Time.now
  @merchant_id = 0
  end

end
