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
    all.find do |item|
      item.id == id
    end
  end

  def self.find_by_name(name)
    all.find do |item|
      item.name == name.downcase
    end
  end

  def self.find_all_with_description(description)
    all.find_all do |item|
      item.description == description.downcase
    end
  end

  def self.find_all_by_price(price)
    all.find_all do |item|
      item.unit_price == price
    end
  end

  def self.find_all_by_price_in_range(range)
    all.find_all do |item|
      range === item.unit_price
    end
  end

  def self.find_all_by_merchant_id(merchant_id)
    all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def self.create(attributes)
    attributes[:id] = all.max do |item|
      item.id
    end.id + 1
    Item.new(attributes)
  end

  def self.update(id, attributes)
    item = all.find do |item|
      item.id == id
    end
    # require 'pry'; binding.pry
    item.instance_variable_set(:@name, attributes[:name])
    # require 'pry'; binding.pry
    item.instance_variable_set(:@description, attributes[:description])
    item.instance_variable_set(:@unit_price, attributes[:unit_price])
  end
end
