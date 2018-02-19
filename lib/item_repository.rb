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

  def find_by_name(name)
    @items.find do |item|
      item.name.downcase == name.downcase
    end
  end
end
