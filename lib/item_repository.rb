require_relative 'item'
require 'pry'
require 'time'
class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end


  def create(attributes)
    if attributes[:id].nil?
      id = @items[-1].id + 1
    else
      id = attributes[:id]
    end
    new_item = Item.new({id: id, name: attributes[:name],
                                  description: attributes[:description],
                                  unit_price: attributes[:unit_price],
                                  created_at: attributes[:created_at].to_s,
                                  updated_at: attributes[:updated_at].to_s,
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
    if find_by_id(id).nil?
      return
    else
      updated_item = find_by_id(id)
    end
    updated_item.name ||= attributes[:name]
    updated_item.description ||= attributes[:description]
    updated_item.unit_price = attributes[:unit_price]
    updated_item.updated_at = Time.now

  end

  def delete(id)
    deleted_item = find_by_id(id)
    @items.delete(deleted_item)
  end

  def inspect
    “#<#{self.class} #{@items.size} rows>”
  end
end
