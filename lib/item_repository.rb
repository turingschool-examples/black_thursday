require 'csv'
require './lib/item'
require 'objspace'
class ItemRepository
  attr_reader :item_repository

  def initialize
    @repository = []
  end

  def all
    # contents = CSV.open './data/items.csv', headers: true, header_converters: :symbol
    # contents.each do |row|
    #   id = row[:id] if row[:id].to_i != 0
    #   puts id
    # end
    # []
    # #         ["id",
    # #  "name",
    # #  "description",
    # #  "unit_price",
    # #  "merchant_id",
    # #  "created_at",
    # #  "updated_at\n"]
    # # reads items.csv
    # # creates an item instance for every line from item
    # # stores every item instance
    ObjectSpace.each_object(Item).to_a
  end
end
