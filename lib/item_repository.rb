require "csv"
require "./lib/item"

class ItemRepository
  def initialize(filepath)
    @items = []
    load_items(filepath)
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end
end
