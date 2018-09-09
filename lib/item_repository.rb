# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'

require_relative 'item'
require_relative 'csv_parse'


class ItemRepository

  attr_reader :items

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    # @headers = [:created_at, :merchant_id, :name, :description, :unit_price, :updated_at]
    @items = []
    make_items
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
    # This is a coincidence that the columns
    # provided are all needed for the Item object
    value.each { |col, data| hash[col] = data }
    return hash
  end

end


# Methods
  # Finder
    # --  make module for find_by(type, attribute) --
    # --  make module for find_all_by(type, attribute) --

    # all
    # find_by_id(id)
    # find_by_name(name)
    # find_all_by_name(name)

  # Maker
    # create(attributes)
    # update(id, attributes)
    # delete(id)
