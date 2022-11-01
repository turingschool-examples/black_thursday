require 'bigdecimal'

class ItemRepository
  attr_reader :items

  def initialize(items)
    @items = items
  end
  
end