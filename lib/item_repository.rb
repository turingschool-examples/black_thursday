# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'

require_relative 'item'
require_relative 'csv_parse'
require './lib/finderclass'

class ItemRepository
  # include Finder

  attr_reader :all,
              :items

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @items = []
    make_items
    @all = items
  end

  def make_items
    @csv.each { |key, value|
      hash = make_hash(key, value)
      item = Item.new(hash)
      @items << item
    }
    @items.flatten!
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end

  def find_by_id(id)
    # retains reader permissions
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



end
