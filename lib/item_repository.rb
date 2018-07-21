require_relative '../lib/item'
require 'csv'
require 'pry'

class ItemRepository

  attr_reader :items

  def initialize(items_location)
      @items_location = items_location
      @items = []
      load_csv
  end

  def load_csv
    CSV.foreach(@items_location, headers: true, header_converters: :symbol) do |row|
      @items << Item.new(row)
    end
  end
end
