class Item
  attr_reader :name, :description, :unit_price, :created_at, :updated_at

  def initialize(item_info)
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = item_info[:unit_price]
    @created_at = item_info[:created_at]
    @updated_at = item_info[:updated_at]
  end
end
