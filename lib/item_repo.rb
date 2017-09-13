require 'pry'
require './lib/item'
require 'csv'

class ItemRepo
  attr_reader :items

  def initialize(file)
    open_file(file)
#    self
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @items = csv.map do |row|
      Item.new(row)
    end
  end

  def all
    items
  end

  def find_by_id(id)
    items.find { |item| item.id == id }
  end

  def find_by_name(name)
    items.find { |item| item.name == name }
  end

  def find_all_with_description(description)
    items.find_all { |item| item.description.downcase.include?(description.downcase) }
  end

  def find_all_by_price(price)
    items.find_all { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    items.find_all { |item| range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all { |item| item.merchant == merchant_id }
  end
end
