require './lib/item'

class ItemRepository
  attr_reader :items_store, :sales_engine, :merchant

  def initialize(parent)
    @items_store = []
    @sales_engine = parent
  end

  def count
    @items_store.count
  end

  def create_item(data)
    my_reference = self
    @items_store << Item.new(data, my_reference)
  end

  def merchant(id)
    @sales_engine.merchant(id)
  end

end
