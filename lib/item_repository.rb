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

  def self.find_by_name(name)
    self.all.find do |item|
      item.name == name.downcase
    # require 'pry'; binding.pry
    end
  end

  def self.find_all_with_description(description)
    #  require 'pry'; binding.pry
     
     self.all.find_all do |item|
      item.description == description.downcase
    end
    # require 'pry'; binding.pry

  end

  def self.find_all_by_price(price)
    self.all.find_all do |item|
      item.unit_price == price
    end
  end

  def self.find_all_by_price_in_range(range)
    self.all.find_all do |item|
      # require 'pry'; binding.pry
      range === item.unit_price
    end
  end

  def self.find_all_by_merchant_id(merchant_id)
    self.all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end


end
