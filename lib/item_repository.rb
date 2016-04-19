require './lib/item'

class ItemRepository

  attr_accessor :items

  def initialize
    @items = []
  end

  def <<(item_obj)
    @items.push(item_obj)
  end

end
