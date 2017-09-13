require 'csv'
require_relative 'item'
require 'pry'

class ItemRepo
  attr_reader :items, :parent

  def initialize(file,se=nil)
    open_file(file)
    @parent = se
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @items = csv.map do |row|
      Item.new(row, self)
    end
  end

  def all
    items
  end

  def find_by_id(merch_id)
    items.find { |item| item.id == merch_id }
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

  def find_all_by_merchant_id(merch_id)
    items.find_all { |item| item.merchant_id == merch_id }
  end

  def item_merchant(id)
    parent.item_merchant(id)
  end
end
