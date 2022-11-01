require 'bigdecimal'
require 'csv'
require './lib/item_repository'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  # contents = CSV.open './data/items.csv', headers: true, header_converters: :symbol
  # contents.each do |row|
  #   id = row[:id] if row[:id].to_i != 0
  #   puts id
  # end
  # []
  #         ["id",
  #  "name",
  #  "description",
  #  "unit_price",
  #  "merchant_id",
  #  "created_at",
  #  "updated_at\n"]
  # reads items.csv
  # creates an item instance for every line from item
  # stores every item instance

  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
    # require 'pry'
    # binding.pry
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
