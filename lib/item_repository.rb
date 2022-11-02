require 'csv'
require "./lib/item"
require "bigdecimal"
class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      # if the ids match
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      # the range includes the unit price
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    item = Item.new(attributes)
    item.id = @items.max_by do |item|
      item.id
    end.id + 1
    item
  end

  def update(id, attributes)
    # new_attributes = find_by_id(id).attributes.merge!(attributes)
    updated = find_by_id(id)
    updated.name = attributes[:name]
    updated.description = attributes[:description]
    updated.unit_price = attributes[:unit_price]
    updated.updated_at = Time.now
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def load_data(file)
    contents = CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        @items << (Item.new(row))
        # require 'pry' ; binding.pry
    end
  end

end
