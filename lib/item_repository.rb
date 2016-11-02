require_relative 'find_functions'
require_relative 'item'
require 'csv'

class ItemRepository

  include FindFunctions

  attr_reader :file_contents,
              :all

  def initialize(file_name = nil)
    return unless file_name
    @file_contents = load(file_name)
    @all           = create_item_objects
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_item_objects
    @file_contents.map {|row| Item.new(row)}
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_by_name(name)
    find_by(:name, name)
  end

  def find_all_with_description(description)
    find_all(:description, description)
  end

  def find_all_by_price(price)
    find_all(:unit_price, price)
  end

  def find_all_by_price_in_range(price_range)
    all.find_all {|item| price_range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    find_all(:merchant_id, merchant_id)
  end

end
