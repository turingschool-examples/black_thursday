require_relative 'csv_parser'
require_relative 'item'
require 'bigdecimal'

class ItemRepository
  include CsvParser
  attr_reader :sales_engine
  attr_accessor :items

  def initialize(file_name, sales_engine)
    @items = []
    item_contents = parse_data(file_name)
    item_contents.each do |row| #should live in it's own method. too much logic in the initialize (some people will say that you should'nt have behavior in initialize, only state)
      @items << Item.new(row, self)
    end
#only pass row and self to the item and assign the values in the item initialize
      @sales_engine = sales_engine
  end

  def all
      @items
  end

  def find_by_id(id)
      @items.find {|item| item.id == id}
  end

  def find_by_name(name)
      @items.find {|item| item.name == name}
  end

  def find_all_with_description(description)
      @items.select {|item| item.description.downcase == description.downcase}
  end

  def find_all_by_price(price)
       @items.select {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
      @items.select {|item| range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
      @items.select {|item| item.merchant_id == merchant_id}
  end


  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
