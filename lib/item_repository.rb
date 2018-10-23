require './lib/repository'

class ItemRepository < Repository
  attr_reader :items

  def initialize
    @items = []
    @collection = @items
  end

  def add_item(item)
    @items << item
  end

end
