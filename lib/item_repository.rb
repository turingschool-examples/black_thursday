# require 'csv'
require './lib/item'

class ItemRepository

  attr_reader :items, :parent, :items_file

  def initialize(items_file, parent)
    @items = create_items(items_file, parent)
    @parent = parent
  end

  def count
    items.count
  end

  def create_item(items_file)
    #check out readlines
    CSV.foreach(items_file, headers: true, header_converters: :symbol) do |row|
      items << Item.new(row, self)
    end
    items << Item.new(data, self)
  end

  def merchant(id)
    parent.merchant(id)
  end

  def all
    return items
  end

  def find_by_id(id)
    items.find do |item|
      item.item_id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.include?(description)
    end
  end

  def find_all_by_merchant_id(id)
    items.find_all do |item|
      item.merchant_id == id
    end
  end

  def find_all_by_price(unit_price)
    items.find_all do |item|
      item.unit_price == unit_price
    end
  end

  def find_all_by_price_in_range(low_price, high_price)
    items.find_all do |item|
      item.unit_price.between?(low_price, high_price)
    end
  end

end


# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
