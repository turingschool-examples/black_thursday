require_relative 'item'
require 'csv'
require 'pry'

class ItemRepository
  attr_reader :engine, :items

  def initialize(csvfile, engine)
    @engine = engine
    @items  = create_hash_of_items(csvfile)
  end

  def create_hash_of_items(csvfile)
    all_items = {}
    csvfile.each do |row|
      all_items[row[:id]] = Item.new(row, self)
    end
    all_items
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items.values
  end

  def find_merchant_vendor(merchant_id)
    @engine.find_merchant_by_id(merchant_id)
  end

  def find_all_items_to_a_merchant(merchant_id)
    all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_by_id(id)
    @items[id.to_s]
  end

  def find_by_name(name)
    all.find do |item|
      if item.name.downcase == name.downcase
        return item
      end
    end
  end

  def find_all_with_description(description)
    all.find_all do |item|
      if item.description.downcase == description.downcase
        item
      end
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      (item.unit_price_to_dollars) == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      item.unit_price <= range.end && item.unit_price >= range.begin
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      if item.merchant_id == merchant_id
        item
      end
    end
  end

end

# def load_items(csvfile)
#   contents = CSV.open csvfile, headers: true, header_converters: :symbol
#   all_items = {}
#   contents.each do |row|
#     all_items[row[:id]] = Item.new(row, self)
#   end
#   all_items
# end
