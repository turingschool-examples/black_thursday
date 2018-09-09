# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'

require_relative 'item'
require_relative 'csv_parse'
require './lib/finder'

class ItemRepository
  include Finder

  attr_reader :all

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    # @headers = [:created_at, :merchant_id, :name, :description, :unit_price, :updated_at]
    @all = []
    make_items
  end

  def make_items
    @csv.each { |key, value|
      hash = make_hash(key, value)
      item = Item.new(hash)
      @all << item
    }
    @all.flatten!
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    # This is a coincidence that the columns
    # provided are all needed for the Item object
    value.each { |col, data| hash[col] = data }
    return hash
  end

  #overrides module
  def find_by_id(id)
    all.keep_if do |item|      
      item.id == id.to_i
    end
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
