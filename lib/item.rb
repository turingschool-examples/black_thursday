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

  # attr_accessor :name

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
    @name = info[:name].downcase
    @description = info[:description].downcase
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    @name = attributes[:name].downcase
    @description = attributes[:description].downcase
    @unit_price = attributes[:unit_price]
    self
  end
end
