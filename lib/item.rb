require 'bigdecimal'
require 'csv'
require './lib/item_repo'

class Item
  include ItemRepo
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data)

    data = CSV.open "./data/items.csv", headers: true, header_converters: :symbol

    data.each do |row|
      @id = row[0]
      @name = row[1]
      @description = row[2]
      @unit_price = row[3]
      @merchant_id = row[4]
      @created_at = row[5]
      @updated_at = row[6]
    end
  end

  def unit_price_to_dollars
    unit_price_to_dollars = @unit_price.to_f
    #returns the price as a float
  end
end

i = Item.new({
    :name => "Pencil",
    :description => "You can use it to write things",
    :unit_price => BigDecimal.new(10.99,4),
    :created_at => Time.now,
    :updated_at => Time.now,
  })

  puts i.name

  puts i.unit_price_to_dollars

  puts i.unit_price
