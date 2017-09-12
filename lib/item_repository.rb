require 'csv'
require_relative 'item'
require 'pry'

class ItemRepository

  attr_reader :items

  def initialize(csv_file_name)
    @items = read_csv(csv_file_name)
    return self
  end

  def read_csv(csv_file_name)
    csv = CSV.read("#{csv_file_name}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Item.new(row)
    end
  end

  def all
    @items
  end

  def find_by_id(id_number)
    @items.find {|item| item.id == id_number}
  end

  def find_by_name(search_name)
    search_name = search_name.downcase
    @items.find do |item|
      item_name = item.name.downcase
      item_name == search_name
    end
  end

  def find_all_with_description(search_term)
    @items.find_all do |item|
      item.description.include?(search_term)
    end
  end

  def find_all_by_price(search_price)
    search_price = search_price.to_i
    @items.find_all do |item|
      item.unit_price == search_price
    end
  end

  def range_includes_end_value?(search_price_range)
    includes = search_price_range.count('.')
    if range == 2
    elsif range == 3
    else
      p "Invalid range. Enter a new price range to search."
    end
  end

  def find_all_by_price_in_range(search_price_range)
    includes = search_price_range.count('.')
    if range == 2
      search_price_range.split('..')
      Range.new(starting_price, ending_price)
    elsif range == 3
      Range.new(starting_price, ending_price-1)
    else
      p "Invalid range. Enter a new price range to search."
    end
  end







end
