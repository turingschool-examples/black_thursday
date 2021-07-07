require 'pry'
require 'csv'
require_relative 'item'

# This is an item repository class
class ItemRepository
  attr_reader :parent, :items

  def initialize(item_csv, parent)
    @parent = parent
    @items = []

    csv_file = CSV.open(item_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @items << Item.new(row, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id)
    @items.find { |item| item.id == id.to_i }
  end

  def find_by_name(name)
    @items.find { |item| name.downcase.casecmp(item.name.downcase).zero? }
  end

  def find_all_with_description(string)
    string = string.downcase
    @items.find_all { |item| item.description.downcase.include?(string) }
  end

  def find_all_by_price(price)
    @items.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      range.member?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    @items.find_all { |item| item.merchant_id == id }
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
