
require 'pry'

require_relative 'csv_parse'
require_relative 'finderclass'

require_relative 'item'


class ItemRepository

  attr_reader :all

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @items = []
    make_items
    @all = @items
  end

  def make_items
    @csv.each { |key, value|
      hash = make_hash(key, value)
      item = Item.new(hash)
      @items << item
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_by_name(name)
    FinderClass.find_by_insensitive(all, :name, name)
  end

  def find_all_with_description(desc)
    FinderClass.find_by_fragment(all, :description, desc)
  end

  def find_all_by_price(price)
    price.class != BigDecimal ? price = BigDecimal.new(price, 4) : price
    # TO DO -  What is the expected format of this price?
    # TO DO - Should we be using the price_in_dollars method ??
    FinderClass.find_all_by(all, :unit_price, price)
  end

  def find_all_by_price_in_range(range) # range instance like (0..200)
    FinderClass.find_by_range(all, :unit_price, range)
  end

  def find_all_by_merchant_id(id)
    FinderClass.find_all_by(all, :merchant_id, id)
  end

end
