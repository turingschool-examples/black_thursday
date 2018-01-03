require 'pry'

require_relative 'item'
require_relative 'create_elements'

class ItemRepo
  attr_reader :items,
              :parent

  include CreateElements

  def initialize(data, parent)
    @items = create_elements(data).reduce({}) do |item_collection, item|
      item_collection[item[:id].to_i] = Item.new(item)
      # item_collection
    end
    @parent = parent
  end

  def all
    items.values
  end

  def find_by_id(id)
    @items.map do |item|
      return item if item.id == id
    end
  end

  def find_by_name(name)
    @items.map do |item|
      return item if item.name == name
    end
  end

  def find_all_with_description(description)
    @items.reduce([]) do |result, item|
      if item.description == description
        result << merchant
      else
        result
      end
    end
  end

  def find_all_by_price(price)
    @items.reduce([]) do |result, item|
      if item.price == price
        result << merchant
      else
        result
      end
    end
  end

  def find_all_by_price_in_range(high, low)
    @items.reduce([]) do |result, item|
      if (low..high).include? item.price
        result << merchant
      else
        result
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.reduce([]) do |result, item|
      if item.merchant_id == merchant_id
        result << merchant
      else
        result
      end
    end
  end

end
