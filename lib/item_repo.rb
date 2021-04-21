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

  def add_item(item)
    @items << item
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
    merchant_item = {}
    @items.each do |item|
      merchant_item[item.merchant_id] = find_all_by_merchant_id(item.merchant_id, @items).length
    end
      merchant_item
  end
end
