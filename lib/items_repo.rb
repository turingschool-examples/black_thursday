require 'CSV'
require './lib/items'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/sales_engine'

class ItemsRepo
  attr_reader :items
  def initialize(data, engine)
    @data = data
    @items = populate_items
    @engine = engine
  end

  def populate_items
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Item.new(data, self)
    end
    items
  end

  def all
    @items
  end

  def group_by_merchant_id
    all.values.group_by{|value| value.merchant_id}
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

  def find_all_by_merchant_id(id)
  	all.find_all do |key,value|
  		value.merchant_id == id
  	end
  end

  def create(attributes)
    max_id = (all.values.max_by{|item| item.id}).id.to_i
    next_id = max_id + 1
    @items[attributes[:merchant_id]] = Item.new({:id => next_id.to_s,
                        :name => attributes[:name].downcase,
                        :description => attributes[:description].downcase,
                        :unit_price => attributes[:unit_price],
                        :merchant_id => attributes[:merchant_id],
                        :created_at => attributes[:created_at],
                        :updated_at => attributes[:updated_at]
                       })
  end

  def delete(arg_id)
  	index = arg_id.to_s
  	all.delete_if do |key, item|
  		item.id == index
  	end
  end


end
