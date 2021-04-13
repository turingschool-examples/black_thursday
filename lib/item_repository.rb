# Basic ItemRepository class
class ItemRepository
  attr_reader :item_array
  
  def initialize(item_array)
    @item_array = item_array
  end
end
