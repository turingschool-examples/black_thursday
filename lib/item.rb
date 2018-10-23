class Item

attr_reader :id, :name, :description, :unit_price
def initialize(item_info)
  @id = item_info[:id]
  @name = item_info[:name]
  @description = item_info[:description]
  @unit_price = item_info[:unit_price]

end

end
