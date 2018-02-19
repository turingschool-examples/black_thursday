require 'CSV'
require_relative '../lib/item'
require 'pry'
class ItemRepository
  def initialize(filepath)
    @items = []
    load_items(filepath)
  end

  def all
    @items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers:true, header_converters: :symbol) do |data|
      @items << Item.new(data)
    end
  end
end
