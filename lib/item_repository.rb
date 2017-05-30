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

  def find_by_id(id)
    return_value = nil
    @items.each do |key, value|
      if key == id
        return_value = value
        puts value
      end
    end
    return_value
  end

  def find_by_name(name)
    @items.each_value do |value|
      if value.name == name
        return value
      else
        return nil
      end
    end
  end

  def find_all_with_description(description_string)
    description_array = []
    @items.each_value do |value|
      description_array << value if value.description.include?(description_string)
    end
    description_array
  end

  def find_all_by_price
  end




end
