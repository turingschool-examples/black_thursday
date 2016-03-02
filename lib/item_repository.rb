require_relative '../sales_engine'
require_relative 'item'
require 'csv'
require 'bigdecimal'
require 'time'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(value_at_item)
    make_items(value_at_item)
  end

  def make_items(item_hashes)
    @items = []
    item_hashes.each do |item_hash|
      @items << Item.new(item_hash)
    end
    @items
  end

  def all
    @items
  end

  def find_by_id

  end

  def find_by_name
  end

  def find_all_with_description
  end

  def find_all_by_price
  end

  def find_all_by_price_in_range
  end

  def find_all_by_merchant_id
  end

end
