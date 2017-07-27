require 'pry'
require 'csv'
require_relative '../lib/item'
require_relative '../lib/file_opener'

class ItemRepository
  include FileOpener
  attr_reader :all_item_data,
              :sales_engine,
              :all

  def initialize(csv_data, sales_engine)
    @sales_engine = sales_engine
    @all_item_data = open_csv(csv_data)
    @all = @all_item_data.map do |row|
      Item.new(row, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      (/#{description}/i) =~ item.description
    end
  end

  def find_all_by_price(unit_price_to_dollars)
    @all.find_all do |item|
      item.unit_price_to_dollars == unit_price_to_dollars
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
      price_range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

end
