# frozen_string_literal: true

require 'pry'
require 'bigdecimal'
require 'time'
require_relative 'item'
# stores items and gives methods for item search
class ItemRepository
  attr_reader :items
  def initialize(items)
    @items = []
    items.each { |item| @items << Item.new(to_item(item))}
  end

  def to_item(item)
    item_hash = {}
    item.each do |line|
      item_hash[line[0]] = line[1]
    end
    item_hash
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(input_id)
    @items.find do |item|
      item.id == input_id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(letters)
    @items.find_all do |item|
      item.description.downcase.include?(letters.downcase)
    end
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

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_highest_id
    @items.max_by(&:id).id
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if attributes[:created_at].nil?
      attributes[:created_at] = Time.now.to_s
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    attributes[:updated_at] = attributes[:updated_at].to_s
    item = Item.new(attributes)
    @items << item
  end

  def update(id, attributes)
    item = find_by_id(id)
    if item.nil?
    else
      temp_attr = sterilize_attributes(attributes, item)
      pairs = attributes.keys.zip(temp_attr.values)
      pairs.each do |pair|
        item.attributes[pair[0]] = pair[1]
      end
      item.attributes[:updated_at] = Time.now
    end
  end

  def sterilize_attributes(attributes, item)
    temp_attr = attributes.dup
    temp_attr[:id] = item.attributes[:id]
    temp_attr[:merchant_id] = item.attributes[:merchant_id]
    temp_attr[:created_at] = item.attributes[:created_at]
    temp_attr
  end

  def delete(id)
    item = find_by_id(id)
    @items.delete(item)
  end
end
