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
      item = Item.new(row[:id], row[:name], row[:description], row[:unit_price], row[:merchant_id], row[:created_at], row[:updated_at])
      @items[item.id] = { :id => item.id, :name => item.name, :description => item.description, :unit_price => item.}
    }
  end

end


items_repo = ItemRepository.new
items_repo.populate_items_repo
binding.pry
puts items_repo.items["263395237"]
