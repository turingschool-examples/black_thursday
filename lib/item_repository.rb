# frozen_string_literal: true

require './lib/item.rb'
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
    @item_list.find { |item| item.name == name }
  end

  def all
    @item_list
  end

  # This method will find the items by searching the entire list for the item
  # with a description instance variable that matches the one given.
  def find_all_with_description(item_description)
    @item_list.find_all { |item| item.description == item_description }
  end

  def find_all_by_price(price)
    @item_list.find_all { |item| item.unit_price == Bigdecimal.new(price) }
  end

  def find_all_by_price_in_range(price_range)
    @item_list.find_all { |item| price_range.to_i.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(id)
    @item_list.find_all { |item| item.merchant_id == id }
  end

  def create(attributes)
    @item_list << Item.new(attributes)
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @item_list.delete(item_to_delete)
  end

  def update(id, attributes)
    item = find_by_id(id)
    attributes.each do |key, value|
      item[key] = value if item.keys.include?(key)
    end
  end
end
