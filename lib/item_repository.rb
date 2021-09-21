# frozen_string_literal: true

require 'csv'
require 'bigdecimal'
require_relative './sales_engine'
require_relative './inspectable'

class ItemRepository
  include Inspectable
  attr_reader :items

  def initialize(data)
    @items = data
  end

  def all
    @items
  end

  def find_by_id(id)
    item_id = nil
    @items.select do |item|
      item_id = item if item.id == id
    end
    item_id
  end

  def find_by_name(name)
    item_name = nil
    @items.select do |item|
      item_name = item if item.name == name
    end
    item_name
  end

  def find_all_with_description(description)
    items_with_description = []
    @items.each do |item|
      if item.description.downcase.include?(description.downcase)
        items_with_description << item
      end
    end
    items_with_description
  end

  def find_all_by_price(price)
    test = @items.find_all do |item|
      item if item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    ranges = []
    ranges << range.first
    ranges << range.last
    items_with_price_in_range = @items.find_all do |item|
      item if item.unit_price_to_dollars.between?(ranges[0], ranges[1])
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item if item.merchant_id == merchant_id
    end
  end

  def highest_id
    new = @items.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_item = Item.new({ id: highest_id,
                          name: attributes[:name],
                          description: attributes[:description],
                          unit_price: attributes[:unit_price],
                          updated_at: Time.now.strftime('%Y-%m-%d'),
                          created_at: Time.now.strftime('%Y-%m-%d'),
                          merchant_id: attributes[:merchant_id] })
    @items << new_item
  end

  def update(id, attributes)
    update = find_by_id(id)
    if update.nil?
      nil
    else
      update.updated_at = Time.now
      if attributes.keys.first == :unit_price
        update.unit_price = attributes.values.first
      elsif attributes.keys.first == :description
        update.description = attributes.values.first
      elsif update.name = attributes.values.first
      else
        update
      end
    end
  end

  def delete(id)
    trash = @items.find do |item|
      item.id == id
    end
    items.delete(trash)
  end
end
