require 'csv'
require_relative './item'
require_relative './repository_methods'
require 'pry'

class ItemRepository

  attr_accessor :collection, :child

  def initialize(path)
    @child = Item
    @collection = Hash.new
    populate_repository(path)
  end

  include RepositoryMethods

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def find_all_with_description(description_fragment)
    items_matching_description = []
    collection.each do |id, item|
      items_matching_description << item if item.description.downcase.include?(description_fragment.downcase)
    end
    items_matching_description
  end

  def find_all_by_price(price)
    items_matching_price = []
    collection.each do |id, item|
      items_matching_price << item if item.unit_price == price
    end
    items_matching_price

  end

  def find_all_by_price_in_range(range)
    range_minimum = range.first
    range_maximum = range.last
    items_matching_supplied_range = []
    collection.each do |id, item|
      items_matching_supplied_range << item if item.unit_price >= range_minimum && item.unit_price <= range_maximum
    end
    items_matching_supplied_range
  end

end
