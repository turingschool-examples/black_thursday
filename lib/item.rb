class Item

attr_reader :id, :name, :description
def initialize(item_info)
  @id = item_info[:id]
  @name = item_info[:name]
  @description = item_info[:description]

end

end
