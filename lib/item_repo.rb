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
                :unit_price  => BigDecimal.new(item[:unit_price]),
                :created_at  => item[:created_at],
                :updated_at  => item[:updated_at],
                :merchant_id => item[:merchant_id].to_i})
    end
    @items
  end

  def all
    @items_csv.map do |row|
      row
    end
  end

  def find_item_by_id(id)
    id_number = []
    item_objects(@items_csv).each do |item|
      id_number << item if item.id == id
    end
    id_number[0]
  end

  def find_by_name(name)
    item_name = []
    item_objects(@items_csv).each do |row|
      item_name << row if row.name == name
    end
    item_name[0]
  end

  def find_all_with_description(description)
    item_objects(@items_csv).find_all do |row|
      row.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    item_objects(@items_csv).find_all do |row|
      row.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    item_objects(@items_csv).find_all do |row|
      range.include?(row.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    item_objects(@items_csv).find_all do |row|
      row.merchant_id == merchant_id
    end
  end

  def create(attributes)
    new_merch = Item.new({id: (sort_by_id[-1].id + 1), 
                        name: attributes[:name],
                 description: attributes[:description],
                  unit_price: attributes[:unit_price],
                  created_at: attributes[:created_at],
                  updated_at: attributes[:updated_at],
                 merchant_id: attributes[:merchant_id]})
    @items << new_merch
    new_merch
  end

  def sort_by_id
    item_objects(@items_csv).sort_by do |row|
      row.id
    end
  end
end