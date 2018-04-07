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
    require "pry"; binding.pry
    @parent = parent
  end

  # This method will find the items by searching the entire list for the item
  # with a description instance variable that matches the one given.
  def find_all_by_description(description)
    @item_list.find_all(&:description)
  end

  def find_all_by_price(price)
  end

  def find_all_by_price_in_range(range)
  end

  def find_all_by_merchant_id(merchant_id)
  end

end
