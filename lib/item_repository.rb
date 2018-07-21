require './lib/item'

class ItemRepository

  def initialize
    @items = []
  end

  def create(params)
    Item.new(params).tap do |item|
      @items << item
    end
  end

  def all
    @items
  end

end
