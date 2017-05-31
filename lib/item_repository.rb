require_relative 'item'
require 'csv'

class ItemRepository
  attr_reader :items

  def initialize(csv)
    @items = CSV.open csv, headers: true, header_converters: :symbol
  end

  def id
    items.each do |row|
      name = row[:id]
      p name
    end

  end

  def name
    items.each do |row|
      name = row[:name]
      p name
    end
  end

  def description
    items.each do |row|
      description = row[:description]
      p description
    end
  end

  def unit_price
    items.each do |row|
      unit_price = row[:unit_price]
      p unit_price
    end
  end
end

test = ItemRepository.new("./data/items.csv")
puts test.name
