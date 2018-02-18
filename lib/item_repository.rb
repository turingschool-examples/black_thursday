require 'pry'

class ItemRepository
  attr_reader :item_list, :parent, :items

  def initialize(item_list, parent)
    @item_list = item_list
    @parent = parent
    @items = []
  end
end
