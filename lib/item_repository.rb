require_relative 'sales_engine'
require_relative 'item'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(hash)
    @items = make_items(hash)
  end

  def make_items(hash)
    @items = []

    hash.each do |key, value|
      @items << Item.new(value)
    end
    @items
  end

end

#
