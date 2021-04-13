require_relative 'sales_engine'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(path)
    @items = []
    make_items(path)
  end

  def make_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
        @items << Item.new(row)
    end
  end

end
