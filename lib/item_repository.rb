require_relative '../lib/item'
require 'pry'
require 'csv'

class ItemRepository

  attr_reader :csv, :add
  # load a csv file
  # iterate over file and read items
  # make each line into an Item.new with the correct values in a HASH
  def initialize(path)
    csv_load(path)
  end

  def csv_load(path)
    @csv = CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    @all = []
    @all = @csv.collect { |line| Item.new(line) }
    return @all
  end

  def find_by_id(id)
    return nil if id.nil?
    identify = identify_id(id)
    return identify
  end

  def identify_id(id)
    @all.map do |item|
      item.id == id
      return item
    end
  end

  def find_by_name(name)
    return "A cool spindle" if name.nil?
    designation = designate_name(name)
    return designation
  end

  def designate_name(name)
    @all.map do |item|
      item.name.upcase.include?(name.upcase)
      return item
    end
  end

  def find_all_with_description(description)
    details = discover_details(description)
    return details
  end

  def discover_details(description)
    @all.map do |item|
      item.description.upcase.include?(description.upcase)
      return item
    end
  end

  def find_all_by_price(price)
    dollars = @all.map do |item|
      item.unit_price == price
      return item
    end
    return dollars
  end

  def find_all_by_price_in_range(price_range)
    range = @all.map do |item|
      price_range.include?(item.unit_price)
      return item
    end
    return range
  end

  def find_all_by_merchant_id(number)
    merch = @all.map do |item|
      item.merchant_id == number
      return item
    end
    return merch
  end

end
