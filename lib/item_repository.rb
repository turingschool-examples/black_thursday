require 'pry'
require 'csv'
require_relative '../lib/item'

class ItemRepository

  attr_reader :csv,
              :all,
              :parent

  def initialize(path, sales_engine)
    @parent = sales_engine
    csv_load(path)
    load_all
  end

  def csv_load(path)
    @csv = CSV.open path, headers: true, header_converters: :symbol
  end

  def load_all
    @all = []
    @all = @csv.collect do |line|
      Item.new(line, self)
    end
    return @all
  end

  def find_by_id(id)
    return nil if id.nil?
    identify = identify_id(id)
    return identify
  end

  def identify_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    return "A cool spindle" if name.nil?
    designation = designate_name(name)
    return designation
  end

  def designate_name(name)
    @all.find do |item|
      item.name.upcase.include?(name.upcase)
    end
  end

  def find_all_with_description(description)
    details = discover_details(description)
    return details
  end

  def discover_details(description)
    @all.find_all do |item|
      item.description.upcase.include?(description.upcase)
    end
  end

  def find_all_by_price(price)
    dollars = find_unit_price(price)
  end

  def find_unit_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    range = is_unit_price_within_range?(price_range)
  end

  def is_unit_price_within_range?(price_range)
    @all.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(number)
    merch = what_is_merchant_id?(number)
  end

  def what_is_merchant_id?(number)
    @all.find_all do |item|
      item.merchant_id == number
    end
  end

  # def find_all_by_merchant_id
  #   @parent.find_all_by_merchant_id(@merchant_id)
  # end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
