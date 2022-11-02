require "csv"
require "pry"
require_relative "find"
require_relative "modify"
require_relative "item"

class ItemRepository
include Find
include Modify
  attr_reader :items

  def initialize
    # @csv_file = csv_file
    @items = []
    # contents = CSV.open(csv_file, headers: true, header_converters: :symbol)
    # contents.each do |row|
    #   @items << Item.new(
    #     id: row[:id].to_i,
    #     name: row[:name],
    #     description: row[:description],
    #     unit_price: row[:unit_price].to_f,
    #     created_at: row[:created_at],
    #     updated_at: row[:updated_at],
    #     merchant_id: row[:merchant_id].to_i
    #     )
    # end
  end

  def add(data)
    @items << Item.new(data)
  end

  def find_all_with_description(descrip)
    @items.find_all do |item|
      item.description.downcase.include?(descrip.downcase)
    end
  end

  def find_all_by_price(price)
    @items.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    @items.find_all do |item|
      item.unit_price.between?(range.first, range.last)
    end
  end
end