require 'csv'
require 'pry'
require './lib/item'
require './lib/sales_engine'

class ItemRepository
  def initialize
  end
end
  # attr_reader :items
  #
  # def initialize(data)
  #
  #   @items = []
  #   #   (all_item_data = []
  #   #     CSV.foreach("./data/items.csv", headers: true) do |row|
  #   #     all_item_data << row.to_hash
  #   #   end
  #   #   all_item_data)
  # end

  # def all
  #   @items
  # end
  #
  # def create_item_objects
  #   @items.map do |item|
  #     Item.new(item)
  #   end
  # end
  #
  # #find_by_name incomplete
  # def find_by_name(item_name)
  #   @items.find do|item|
  #     item == item_name
  #   end
  # end
