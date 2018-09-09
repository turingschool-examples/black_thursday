require 'CSV'
require 'pry'
require_relative './item'

class ItemRepository
  def initialize(item_path)
    @items = []
    make_items(item_path)
  end

  def all
    @items
  end

  def make_items(item_path)
    CSV.foreach(item_path, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

end
