require 'bigdecimal'
require 'CSV'
require 'time'

class ItemRepo

  attr_reader :items
  def initialize 
    @items = []
  end

  def populate_information
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol) do |item_info|
      items[item_info[:id]] = Item.new(item_info)
    end
      items
  end

  def all 
    #returns array of all known item instances
   @items = populate_information.map do |item|
      item[1]
    end
  end

  def find_by_id(id)
    populate_information.select do |item|
      item[id] == id
    end
  end
end