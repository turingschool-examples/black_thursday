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

  def find_by_id(id)
  @items.find do |item|
     item.id == id
    end
  end

  def find_by_name(name)
   @items.find do |items|
      item.name == name
    end
  end


end
