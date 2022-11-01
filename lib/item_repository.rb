require "csv"
require "pry"
require_relative "find"

class ItemRepository
include Find
  attr_reader :items
  
  def initialize(csv_file)
    @csv_file = csv_file
    @items = []
  end

  def find_all_with_description(descrip)
    @items.find_all do |item|
      item.description.downcase.include?(descrip.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end
end