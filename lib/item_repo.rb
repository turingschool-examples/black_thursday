require_relative 'item'

class ItemRepository
  def initialize(item_list)
    @item_list = item_list
  end
  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
