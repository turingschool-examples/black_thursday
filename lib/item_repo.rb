require_relative 'item'
require 'pry'
class ItemRepo

  attr_reader :items

  def initialize(file,se = nil)
    @items = {}
    open_file(file)

  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      data = row.to_h
      items[data[:id].to_i] = Item.new(data, self)
    end
  end

  def all
    items.values
  end

  def find_by_id(id)
    items[id]
  end

  def find_by_name(name)
    all.find {|item| item.name.downcase == name.downcase}
  end

  def find_by_description(desc)
    all.find do |item|
      item.description.downcase.include?(desc.downcase)
    end
  end

  def find_by_price(price)
    price /= 100
    all.find {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    range = range.map {|x| (x/100).to_f}
    all.find_all do |item|
      range.include?(item.unit_price.to_f)
    end
  end

  def find_by_merchant_id(id)
    all.find {|item| item.merchant_id == id}
  end
end
