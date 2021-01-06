require 'CSV'
require './lib/cleaner'
require './lib/item'

class ItemRepository
  attr_reader 

  def initialize(file = './data/items.csv')
    @file = file
    @items = []
    @cleaner = Cleaner.new
    @items_csv = @cleaner.open_csv(@file)
  end

  def item_objects(items)
    items.each do |item|
     @items << Item.new({:id => item[:id].to_i,
                :name        => item[:name],
                :description => item[:description],
                :unit_price  => item[:unit_price],
                :created_at  => item[:created_at],
                :updated_at  => item[:updated_at],
                :merchant_id => item[:merchant_id]})
    end
    @items
  end

  def all
    @items_csv.map do |row|
      row
    end
  end

  def find_item_by_id(id)
    name = []
    item_objects(@items_csv).each do |item|
      name << item if item.id == id
    end
    name[0]
  end

end