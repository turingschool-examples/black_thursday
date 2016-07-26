require './lib/item'

class ItemRepository
  attr_reader :list_of_items

  def initialize(items_data)
    @list_of_items = []
    populate_items(items_data)
  end

  def populate_items(items_data)
    @list_of_items = items_data.map do |datum|
      Item.new(datum)
    end
  end

  def all
    list_of_items
  end

end
