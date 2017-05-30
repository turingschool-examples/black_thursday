require './lib/item.rb'
require 'csv'
require 'pry'

class ItemRepository

  attr_reader :items

  def initialize
    @items = {}
  end

  def populate_items_repo
    items_list = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
    items_list.each { |row|
      item = Item.new({ :id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :merchant_id => row[:merchant_id], :created_at => row[:created_at], :updated_at => row[:updated_at]})
      @items[item.id] = item
    }
  end

  def all
    @items.values
  end

end
