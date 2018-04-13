# frozen_string_literal: true

require 'bigdecimal'
require 'time'
require_relative 'item.rb'
# require './lib/search.rb'
# require './lib/change_module.rb'
# This object holds all of the items. On initialization, we feed in the
# seperated out list of items, which we obtained from the CSV file. For each
# row, denoted here by the item variable, we insantiate a new item object that
# includes a reference to it's parent. We store this list in the item_list
# isntance variable, allowing us to reference the list outside of this class.
# The list is stored as an array.
class ItemRepository
  # include Search
  # include ChangeModule
  attr_reader :item_list,
              :parent
  def initialize(items, parent)
    @item_list = items.map { |item| Item.new(item, self) }
    @parent = parent
  end

  def find_by_id(id)
    @item_list.find { |item| item.id == id }
  end

  def find_by_name(name)
    @item_list.find { |item| item.searchable_name == name.downcase }
  end

  def all
    @item_list
  end

  # This method will find the items by searching the entire list for the item
  # with a description instance variable that matches the one given.
  def find_all_with_description(item_description)
    @item_list.find_all do |item|
      item.searchable_desc == item_description.downcase
    end
  end

  def find_all_by_price(price)
    @item_list.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @item_list.find_all do |item|
      price_range.include?(item.item_specs[:unit_price])
    end
  end

  def find_all_by_merchant_id(id)
    @item_list.find_all { |item| item.item_specs[:merchant_id] == id }
  end

  def create(attributes)
    id_array = @item_list.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @item_list << Item.new(attributes, self)
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @item_list.delete(item_to_delete)
  end

  def update(id, attributes)
    item = find_by_id(id)
    unchangeable_keys = [:id, :item_id, :created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if item.item_specs.keys.include?(key)
        item.item_specs[key] = value
        item.item_specs[:updated_at] = Time.now
      end
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    @parent.find_merchant_by_merchant_id(merchant_id)
  end

  def inspect
    "<#{self.class} #{@item_list.size} rows>"
  end
end
