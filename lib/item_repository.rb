require 'csv'
require 'bigdecimal'
require_relative '../lib/item'

class ItemRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      item = Item.new(row)
      @all << item
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.casecmp?(name)
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.casecmp?(description)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    new_id = @all.max_by do |item|
      item.id
    end

    attributes[:id] = new_id.id + 1

    item = Item.new(attributes)
    @all << item
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    if !item.nil?
      item.update(attributes)
    end
  end

  def delete(id)
    delete_item = find_by_id(id)
    @all.delete(delete_item)
  end
end
