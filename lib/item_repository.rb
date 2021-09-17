require 'csv'
require_relative './sales_engine'

class ItemRepository
  attr_reader :items

  def initialize(data)
    @items = data
    # require "pry"; binding.pry
  end

  def all
    @items
  end

  def find_by_id(id)
    item_id = nil
    @items.select do |item|
      if item.id == id
        item_id = item
      end
    end
    item_id
  end

  def find_by_name(name)
    item_name = nil
    @items.select do |item|
      if item.name == name
        item_name = item
      end
    end
    item_name
  end

  def find_all_with_description(description)
    items_with_description = []
    @items.each do |item|
      if item.description.include?(description)
        items_with_description << item
      end
    end
    items_with_description
  end
end
