require_relative 'item'
require_relative 'find'
require_relative 'csv_io'

class ItemRepository
  include Find
  include CSV_IO

  attr_accessor :items
  attr_reader :file, :sales_engine

  def initialize(file=nil, sales_engine)
    @file = file
    @items = []
    @sales_engine = sales_engine
  end

  def add_new(data, sales_engine)
    items << Item.new(data, sales_engine)
  end

  def all
    @items
  end

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_by_name(name)
    find_by_string({:name => name})
  end

  def find_all_with_description(partial)
    find_all_by_string_fragment({:description => partial})
  end

  def find_all_by_merchant_id(id)
    find_all_by_num({:merchant_id => id})
  end

  def find_all_by_price(price)
    tolerance = 0.0000
    @items.find_all do |item|
      (item.unit_price_to_dollars - price).abs <= tolerance
    end
  end

  def find_all_by_price_in_range(range)
    tolerance = 0.0000
    @items.find_all do |item|
      item.unit_price_to_dollars >= (range.begin - tolerance) &&
      item.unit_price_to_dollars <= (range.end + tolerance)
    end
  end

end
