require 'csv'
require './lib/item'
require 'objspace'
class ItemRepository
  

  def self.all
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

  def self.find_by_id(id)
    self.all.find do |item|
      item.id == id
    # require 'pry'; binding.pry
    end
  end
end
