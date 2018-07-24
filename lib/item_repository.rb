require 'csv'
require_relative '../lib/item.rb'

class ItemRepository
  def initialize(items_file)
    @items = [ ]
  end

  def create_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
  @items.find do |item|
    item.id == id
  end
end

def find_by_name(name)
  @items.find do |item|
    item.name.downcase == name.downcase
  end
end

def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
end

def find_all_by_price(price)
  @items.find_all do |item|
    item.unit_price == price
  end
end


end
