require './lib/items.rb'
require 'csv'

class ItemRepository

  attr_reader :items

  def initialize
    @items = []
  end

  def populate_items_repo
    items_list = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
    items_list.each { |row|
      item = Item.new(row[:id], row[:name], row[:description], row[:unit_price], row[:merchant_id], row[:created_at], row[:updated_at])
      @items << item
    }
  end

end

item_repo = ItemRepository.new
item_repo.populate_items_repo
p item_repo.id
