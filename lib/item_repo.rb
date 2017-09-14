require_relative 'item'
require_relative 'sales_engine'

class ItemRepository
  def self.read_items_file(items, sales_engine)
    item_list =[]
    CSV.foreach(items, headers: true, header_converters: :symbol) do |row|
      item_info = {}
      item_info[:id] = row[:id]
      item_info[:name] = row[:name]
      item_info[:description] = row[:description]
      item_info[:unit_price] = row[:unit_price]
      item_info[:created_at] =row[:created_at]
      item_info[:updated_at] = row[:updated_at]
      item_info[:merchant_id] = row[:merchant_id]
      item_list << Item.new(item_info)
    end
    ItemRepository.new(item_list, sales_engine)
  end

  attr_reader :items, :sales_engine
  def initialize(items, sales_engine)
    @items = items
    @sales_engine = sales_engine
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(word)
    items.find_all do |item|
      item.description.downcase.include?(word.downcase)
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.cover?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  # def merchants(items)
  # end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
