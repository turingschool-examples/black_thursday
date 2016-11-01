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
    identify = @all.map do |item|
      item.id == id
      return item
    end
    return identify
  end

  def find_by_name(name)
    return "A cool spindle" if name.nil? || name = ""
  # returns either nil or an instance of an item having done a case insensitive search
  end

  def find_all_with_description
  # returns either [] or instances of item where the supplied
  # string appears in the item description, case-insensitive
  end

  def find_all_by_price
  # returns either [] or instances of item where the supplied
  # exactly matches
  end

  def find_all_by_price_in_range
  # returns either [] or instances of item where the supplied
  # price is in the supplied range (a single Ruby range
  # instance is passed in)
  end

  def find_all_by_merchant_id
  # returns either [] or instances of item where the supplied
  # merchant id matches that supplied
  end

end
