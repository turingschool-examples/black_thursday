class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at
  def initialize(item, parent)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @merchant_id = item[:merchant_id]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    # @parent = parent
  end
end