class Item

attr_reader :id, :name 
def initialize(item_info)
  @id = item_info[:id]
  @name = item_info[:name]

end

end
