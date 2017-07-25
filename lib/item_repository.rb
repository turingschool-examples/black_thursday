require './lib/item'
require 'pry'

class ItemRepository
  attr_reader :items

  def initialize(items_file_path, se)
    @items = []
    contents = CSV.open items_file_path,
                 headers: true,
                 header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      item = Item.new(id, name, description, unit_price, created_at, updated_at)
      @items << item
    end
  end
end




# def self.load_items(items_file_path)
#   ir = ItemRepository.new
#   contents = CSV.open items_file_path,
#              headers: true,
#              header_converters: :symbol
#   contents.each do |row|
#     id = row[:id]
#     name = row[:name]
#     description = row[:description]
#     unit_price = row[:unit_price]
#     created_at = row[:created_at]
#     updated_at = row[:updated_at]
#     item = Item.new(id, name, description, unit_price, created_at, updated_at)
#     ir.items << item
#   end
#   # ir
# end