require_relative 'item'
require 'csv'
require 'bigdecimal'

class ItemRepository
  attr_reader   :contents,
                :items,
                :parent

  def initialize(path, parent = nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @items = contents.map do |line|
      Item.new(line, self)
    end
  end

  def all
    @items
  end

  def find_by_id(id_number)
    items.find do |item|
      item.id == id_number
    end
  end

  def find_by_name(name)
    items.find do |item|
      item.name.downcase == name.downcase
    end 
  end

  def find_all_with_description(description)
    items.find_all do |item|
      item.description.downcase == description.downcase
    end
  end

  def find_all_by_price(price)
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items.find_all do |item|
      range.include?(item.unit_price_to_dollars)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    items.find_all do |item|
      item.merchant_id.to_i == merchant_id
    end
  end

  def find_merchant(merchant_id)
    parent.find_merchant(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

end