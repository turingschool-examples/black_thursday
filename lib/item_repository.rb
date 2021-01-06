require 'csv'
require './lib/item'

class ItemRepository
  attr_reader :filename,
              :items

  def initialize(filename)
    @filename = filename
    @items = Array.new
    generate_items(filename)
  end

  def generate_items(filename)
    items = CSV.open filename, headers: true, header_converters: :symbol
    items.each do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items.length
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id.to_s
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    price_fix = "#{price}00"
    @items.find_all do |item|
      item.unit_price == price_fix
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price.to_f / 100)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id.to_s
    end
  end

  def create(attributes)
    id = @items[-1].id.to_i
    id += 1
    id = id.to_s
    attributes[:id] = id
    string_unit_price = attributes[:unit_price].to_f
    attributes[:unit_price] = string_unit_price
    item = Item.new(attributes)
    @items.push(item)
  end
end
# row[:id], row[:name], row[:description], row[:unit_price], row[:created_at], row[:updated_at], row[:merchant_id]

# ir = ItemRepository.new("./data/items.csv")
