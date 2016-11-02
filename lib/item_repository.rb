require_relative 'item'
require 'csv'
require 'pry'

class ItemRepository
  attr_reader   :contents,
                :items

  def initialize(path)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @items = contents.map do |line|
      Item.new(line)
    end
  end

  def all
    @items
  end

  def find_by_id(id_number)
    value = nil
    items.each do |item|
      value = item if item.id == id_number
    end
    value
  end

  def find_by_name(name)
    value = nil
    items.each do |item|
      value = item if item.name.downcase == name.downcase
    end 
    value
  end

  def find_all_with_description(description)
    match = []
    items.each do |item|
      match << item if item.description.downcase == description.downcase
    end
    match
  end

  def find_all_by_price(price)
    match = []
    items.each do |item|
      match << item if item.unit_price == price
    end
    match
  end

  def find_all_by_price_in_range(range)
    match = []
    items.each do |item|
      match << item if range.include?(item.unit_price_to_dollars)
    end
    match
  end

  def find_all_by_merchant_id(merchant_id)
    match = []
    items.each do |item|
      match << item if item.merchant_id.to_i == merchant_id
    end
    match
  end

end