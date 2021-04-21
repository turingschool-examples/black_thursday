require_relative 'sales_engine'
require_relative 'item'
require_relative 'mathable'
require 'bigdecimal'

class ItemRepository
  include Mathable
  attr_reader :items

  def initialize(path, engine)
    @items = []
    @items_hash = {}
    @engine = engine
    make_items(path)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def make_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      item =Item.new(row, self)
      @items << item
      @items_hash[row[:id]] = item
    end
  end

  def find_by_id_hash(id)
    @items_hash[id].value
  end

  def all
    @items
  end

  def create(attributes)
    attributes[:id] = RepoBrain.generate_new_id(@items)
    @items << Item.new(attributes, self)
  end

  def delete(id)
    items.delete(find_by_id(id))
  end

  def find_all_by_merchant_id(merchant_id)
    RepoBrain.find_all_by_id(merchant_id, 'merchant_id', @items)
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_with_description(description)
    RepoBrain.find_all_by_partial_string(description, 'description', @items)
  end

  def find_by_id(id)
    RepoBrain.find_by_id(id, 'id', @items)
  end

  def find_by_name(name)
    RepoBrain.find_by_full_string(name, 'name', @items)
  end

  def golden_items
    hash = item_price_hash
    std_dev_times2 = (average(hash) + (standard_deviation(hash) * 2))
    hash.each_with_object([]) do |(item_id, price), array|
      if price > std_dev_times2
        array << find_by_id(item)
      end
    end
  end

  def item_price_hash
    @_item_price_hash ||= @items.each_with_object({}) do |item, hash|
      hash[item.id] = item.unit_price
    end
  end

  def items_created_in_month(month)
    @items.each_with_object(Hash.new(0)) do |item, hash|
      hash[item.merchant_id] += 1
    end
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      item_to_update = find_by_id(id)
      item_to_update.update(attributes)
    end
  end
end
