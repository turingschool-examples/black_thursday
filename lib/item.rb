class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at

  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price]
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
  end

end
