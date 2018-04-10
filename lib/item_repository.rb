# frozen_string_literal: true

require 'csv'
require_relative 'item'

# This is an ItemRepositoryTest class
class ItemRepository
  attr_reader :items

  def initialize
    @items = []
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id }
  end

  def find_by_name(name)
    @items.find { |item| item.name.downcase == name.downcase }
  end

  def find_all_with_description(item_description)
    @items.find_all do |item|
      item.description.downcase.include?(item_description.downcase)
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

  def find_all_by_merchant_id(id)
    @items.find_all { |item| item.merchant_id == id }
  end

  def find_highest_id
    @items.map(&:id).max
  end

  def create_new_id
    find_highest_id + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @items << Item.new(attributes)
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.name = attributes[:name]
    to_update.description = attributes[:description]
    to_update.unit_price = attributes[:unit_price]
    to_update.updated_at = Time.now.to_s
  end

  def delete(id)
    to_delete = find_by_id(id)
    @items.delete(to_delete)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
