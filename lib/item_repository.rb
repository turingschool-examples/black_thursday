require 'csv'
require_relative './sales_engine'

class ItemRepository
  attr_reader :items

  def initialize(data)
    @items = data
  end

  def all
    @items
  end

  def find_by_id(id)
    item_id = @items.select do |item|
      item.id == id
    end
    item_id
  end

  def find_by_name(name)
    item_name = @items.select do |item|
      item.name == name
    end
    item_name
  end
end
