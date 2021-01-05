require 'csv'
require './lib/item'
class ItemRepository
  attr_reader :filename,
  :items
  def initialize(filename)
    @filename = filename
    @items = Array.new
    generate_items(filename)
  end

  def generate_items(filename)
    items = CSV.open filename, headers: true, header_converters: :symbol
    items.each do |row|
      @items << Item.new(row)
    end
  end

  def unit_price_to_dollars
  end
end
# row[:id], row[:name], row[:description], row[:unit_price], row[:created_at], row[:updated_at], row[:merchant_id]

# ir = ItemRepository.new("./data/items.csv")
