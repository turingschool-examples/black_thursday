require 'csv'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_accessor :items

  def initialize(items_data)
    @items = items_data.map do |item_data|
      Item.new(item_data)
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.find do |item|
      item.id == id.to_i
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name == name.downcase
    end
  end

  def find_all_with_description(description)
    descriptions = items.select do |items|
      items.description.include? description.downcase
    end
    descriptions
  end

  def find_all_by_price

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
