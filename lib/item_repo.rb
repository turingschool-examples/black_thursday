require 'CSV'
require 'bigdecimal'
require 'item'
require_relative 'findable'

class ItemRepo
  include Findable
  attr_reader :items,
              :engine

  def initialize(path, engine)
    @items = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @items << Item.new(data, self)
    end
  end

  def all
   @items
  end

  def create(attributes)
     item = Item.new(attributes, self)
     max = @items.max_by do |item|
       item.id
     end
     item.update_id(max.id)
     @items << item
     item
  end

  def update(id, attributes)
    item = find_by_id(id, @items)
    return if !item
    item.update_all(attributes)
  end

  def delete(id)
    @items.delete(find_by_id(id, @items))
  end

  def average_price
    price_total = @items.sum do |item|
      item.unit_price_to_dollars
    end
    price_total / all.length
  end

  def item_count_per_merchant
    items_per_merchant = {}
    @items.each do |item|
      items_per_merchant[item.merchant_id] = find_all_by_merchant_id(item.merchant_id, @items).length
    end
      items_per_merchant
  end

  def average_item_price_standard_deviation
    average = average_price
    sum = all.sum do |item|
      (average - item.unit_price_to_dollars)**2
    end
    sum = (sum / all.length.to_f)
    (sum ** 0.5).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    all_items = find_all_by_merchant_id(merchant_id, @items)
    sum = all.sum do |item|
      item.unit_price
    end
    (sum / all.length).round(2)
  end
end
