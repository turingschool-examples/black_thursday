require 'CSV'
require 'bigdecimal'
require 'item'
require_relative 'findable'
include Findable

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

  def create(attributes)
    item = Item.new(attributes)
    max = @items.max_by do |item|
      item.id
    end
    item.id = max.id + 1
    add_item(item)
    item
  end

  # the code logic doesn't belong here, what happens when only one gets updated
  def update(id, attributes)
    new_item = find_by_id(id)
    return if !new_item
    new_item.name = attributes[:name] if  attributes[:name]
    new_item.description = attributes[:description] if attributes[:description]
    new_item.unit_price = attributes[:unit_price] if attributes[:unit_price]
    new_item.updated_at = Time.now
    new_item
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
