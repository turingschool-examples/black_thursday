require 'pry'
require 'CSV'
require './lib/merchant'
require './lib/sales_module'

class ItemRepository

  include Repository

  attr_reader :repository

  def initialize(csv_items)
    @repository  = []
    create_item(csv_items)
  end

  def create_item(csv_items)
    row_objects = CSV.read(csv_items, headers: true, header_converters: :symbol)
      @repository = row_objects.map do |row|
        Item.new(row)
      end
  end

  def find_all_with_description(item_description)
    @repository.find_all do |item|
      item.description.upcase == item_description.upcase
    end
  end

  def find_all_by_price(price)
    @repository.find_all do |item|
      item.unit_price == price
    end
  end

end
