require_relative 'searching'
require_relative 'item'

# Creates and manages item repository
class ItemRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @all = add_items
    @sales_engine = sales_engine
  end

  def add_items
    data.map { |row| Item.new(row, self) }
  end

  def find_all_with_description(fragment)
    @all.find_all do |obj|
      obj.description.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all { |obj| obj.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |obj|
      range.include?(obj.unit_price.to_f)
    end
  end

  def merchant(id)
    @sales_engine.find_item_merchant(id)
  end

  def inspect
    self
  end
end
