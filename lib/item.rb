class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  def initialize(params)
    @id = params[0]
    @name = params[1]
    @description = params[2]
    @unit_price = params[3]
    @created_at = Time.now
    @updated_at = Time.now
    @merchant_id = 0
  end

end
