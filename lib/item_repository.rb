require 'csv'
require_relative 'item'
require_relative 'sales_module'

class ItemRepository
  attr_reader :all
  def initialize(csv)
    @all = Item.read_file(csv)
  end

  def find_all_with_description(description)
    found = []
    found << @all.find_all{|item| item.description.downcase == description.downcase}
    found.flatten
  end

  def find_all_by_price(price)
    found = []
    found << @all.find_all{|item| item.unit_price.to_f == price}
    found.flatten
  end

  def find_all_by_price_in_range(range)
    found = []
    found << @all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
    return found.flatten
  end


  include SalesModule

end
