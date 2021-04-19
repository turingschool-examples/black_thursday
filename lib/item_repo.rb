require 'CSV'
require 'bigdecimal'
require 'item'

class ItemRepo
  attr_reader :items

  def initialize(path, engine)
    @items = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data)
    end
  end

  def all
   @items
  end

  def add_item(item)
    @items << item
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
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
    (range).include?(item.unit_price)
    end
  end

  # This method needs to be refactored
  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    item = Item.new(attributes)
    max = @items.max_by do |item|
      item.id
    end
    item.id = max.id + 1
    add_item(item)
    item
  end

  def update(id, attributes)
    item = find_by_id(id)
    return if !item
    item.update_all(attributes)
  end

  def delete(id)
    @items.delete(find_by_id(id))
  end

  def average_price #Needs spec
    price_total = @items.sum do |item|
      item.unit_price_to_dollars
    end
    price_total / all.length
  end

  def item_count_per_merchant #Needs spec
    merchant_item = {}
    @items.each do |item|
      merchant_item[item.merchant_id] = find_all_by_merchant_id(item.merchant_id).length
    end
      merchant_item
  end

  def item_count_per_merchant #Needs spec
    merchant_item = {}
    @items.each do |item|
      merchant_item[item.merchant_id] = find_all_by_merchant_id(item.merchant_id).length
    end
      merchant_item
  end
end
