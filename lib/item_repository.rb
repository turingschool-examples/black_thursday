require_relative '../lib/item'
require 'pry'
class ItemRepository

  def initialize
    @items = []
  end

  def inspect
   “#<#{self.class} #{@items.size} rows>”
  end

  def create(attributes)
    new_item = Item.new({id: attributes[:id], name: attributes[:name],
                                  description: attributes[:description],
                                  unit_price: attributes[:unit_price],
                                  created_at: attributes[:created_at],
                                  updated_at: attributes[:updated_at],
                                  merchant_id: attributes[:merchant_id]})
    @items << new_item
    return new_item
  end

  def all
    @items
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
      item.unit_price_to_dollars == price

    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def update(id, attributes)
    updated_item = find_by_id(id)
    updated_item.name = attributes[:name]
    updated_item.description = attributes[:description]
    updated_item.unit_price = attributes[:unit_price]
    updated_item.updated_time = Time.now
  end

  def delete(id)
    deleted_item = find_by_id(id)
    @items.delete(deleted_item)
  end
end
