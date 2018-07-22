require 'csv'
require_relative '../lib/item.rb'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(item_location)
    @item_location = item_location
    @items = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@item_location, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end

  def all
    @items
  end
end
