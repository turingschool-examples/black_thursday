# Create a repository of Item objects
#   - makes all item objects
#   - uses finder & CRUD modules

require 'pry'

require_relative 'item'
require_relative 'csv_parse'
require './lib/finder'

class ItemRepository
  include Finder

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

end


