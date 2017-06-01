require './lib/item.rb'
require 'csv'
require 'pry'

class ItemRepository

  attr_reader :items

  def initialize(csv_file)
    @items = []
    populate_items_repo(csv_file)
  end

  def populate_items_repo(csv_file)
    items_list = CSV.open csv_file, headers: true, header_converters: :symbol
    items_list.each do |row|
      item = Item.new({ :id => row[:id], :name => row[:name], :description => row[:description], :unit_price => row[:unit_price], :merchant_id => row[:merchant_id], :created_at => row[:created_at], :updated_at => row[:updated_at]})
      @items << item
    end
    items_list.close
  end

  def all
    @items.each {|item| puts item}
  end

  def find_by_id(id)
    return_value = nil
    @items.each do |item|
      if item.id == id
        return_value = item
        puts item
      end
    end
    return_value
  end

  def find_by_name(name)
    return_value = nil
    @items.each do |item|
      if item.name == name
        return_value = item
        puts item
      end
    end
    return_value
  end

  def find_all_with_description(description_string)
    description_array = []
    @items.each do |item|
      description_array << item if item.description.include?(description_string)
    end
    puts description_array
    description_array
  end

  def find_all_by_price(item_price)
    prices_array = []
    @items.each do |item|
      prices_array << item if item.unit_price_to_dollars == item_price
    end
    puts prices_array
    prices_array
  end

  def find_all_by_price_in_range(range)
    prices_range_array = []
    @items.each do |item|
      prices_range_array << item if range.include?(item.unit_price_to_dollars)
    end
    puts prices_range_array
    prices_range_array
  end

  def find_all_by_merchant_id(input_id)
    by_merchant_id_array = @items.select do |item|
      item.merchant_id == input_id.to_s
    end
    puts by_merchant_id_array
    by_merchant_id_array
  end

end
