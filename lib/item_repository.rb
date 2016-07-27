require './lib/item'

class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = []
  end
