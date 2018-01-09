require 'csv'
require 'time'
require_relative '../lib/item'
require_relative '../lib/csv_parser'
require 'pry'


class ItemRepository

  include CsvParser

  attr_reader :items_csv,
              :items,
              :se

  def initialize(csv_file, se)
    @items = []
    @se = se
    parser(csv_file).each { |row| @items << Item.creator(row, self) }
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @items.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    @items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      item if range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @items.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_item(id) # NEEDS TESTS!!
    items.find_all do |item|
      item.merchant_id == id
    end
  end

  def find_merchant(id) # NEEDS TESTS!!
    se.find_merchant_by_id(id)
  end


end
