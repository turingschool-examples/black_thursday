require_relative '../lib/item'
require 'csv'
require 'pry'

class ItemRepository

  def initialize(items_location)
      @items = []
    CSV.foreach(items_location, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end
end
