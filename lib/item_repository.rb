require './lib/item'

class ItemRepository
  attr_reader :array

  def initialize
    @array = []
  end
end