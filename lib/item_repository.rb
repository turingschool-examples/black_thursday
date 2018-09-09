require_relative './item'

class ItemRepository

  def initialize(filepath)
    @items = []
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |data|
      @items << Item.new(data)
    end
  end

  def all
    @items
  end
end
