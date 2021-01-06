require 'CSV'
require './lib/items'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'

class ItemsRepo
  attr_reader :items
  def initialize(data)
    @data = data
    @items = populate_items
  end

  def populate_items
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |row|
      items[row[:id]] = Item.new({:id => row[:id],
                          :name => row[:name],
                          :description => row[:description],
                          :unit_price => row[:unit_price],
                          :merchant_id => row[:merchant_id],
                          :created_at => row[:created_at],
                          :updated_at => row[:updated_at]
                         })
    end
    items
  end

  def all
    @items
  end

  def find_by_id (id)
    all.values.find do |item|
      item.id == id
    end
  end

  def find_by_price (price)
    all.values.find_all{|item| item.unit_price == price}
  end

  def find_by_name(name)
  	all.values.find do |item|
  		item.name == name
  	end
  end

  def find_all_with_description(description)
  	desc_str = description.split

  	all.values.find_all do |item|
  		item if desc_str.any? {|string|  item.description.include? string.downcase}
  	end
  end

  def find_all_by_price_in_range(range)
  	all.values.find_all do |item|
  		range.include?(item.unit_price_to_dollars)
  	end
  end

  def update (update_item)
    name = update_item[:name]
    description = update_item[:description]
    unit_price = update_item[:unit_price]
    id = update_item[:id]
    item = find_by_id(id)
    item.update_item_name(name)
    item.update_item_description(description)
    item.update_item_unit_price(unit_price)
    item.updated_at = Time.now
  end

end
