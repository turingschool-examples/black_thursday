require 'csv'
require './lib/item'

class ItemRepository

  attr_reader :items

  def initialize(csv_filepath)
    @items = []
    create_items(csv_filepath)
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find {|item| item.id == id}
  end

  def find_by_name(name)
    @items.find {|item| item.name.downcase == name.downcase}
  end

  def find_all_with_description(string)
    @items.find_all {|item| item.description.include?(string)}
  end

  def find_all_by_price(price)
    @items.find_all {|item| item.unit_price_to_dollars == price}
  end

  def find_all_by_price_in_range(range)
    @items.find_all {|item| range === item.unit_price_to_dollars}
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all {|item| item.merchant_id == merchant_id}
  end

private

  def create_items(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      create_item_hash(id, name, description, unit_price, merchant_id, created_at, updated_at)
    end
  end

  def create_item_hash(id, name, description, unit_price, merchant_id, created_at, updated_at)
    item_creation_hash = {}
    item_creation_hash[:id] = id
    item_creation_hash[:name] = name
    item_creation_hash[:description] = description
    item_creation_hash[:unit_price] = unit_price
    item_creation_hash[:merchant_id] = merchant_id
    item_creation_hash[:created_at] = created_at
    item_creation_hash[:updated_at] = updated_at
    item_creation_hash
    add_item(item_creation_hash)
  end

  def add_item(item_creation_hash)
    @items << Item.new(item_creation_hash)
  end

end
