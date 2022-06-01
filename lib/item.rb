class Item

  attr_reader :id, :name, :description, :unit_price

  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price]
  end

end
