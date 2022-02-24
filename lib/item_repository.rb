require 'csv'
require_relative 'item'

class ItemRepository
  def initialize(csv)
    @all_items = Item.read_file(csv)
  end

  def all
    @all_items
  end

end
