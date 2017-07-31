require 'csv'
require_relative 'item'
require 'pry'
class ItemRepo

  attr_reader :items, :parent

  def initialize(file, se=nil)
    @items = {}
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      items[row[:id].to_i] = Item.new(row, self)
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

  def find_all_with_description(desc)
    all.find_all do |item|
      item.description.downcase.include?(desc.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(id)
    all.find_all {|item| item.merchant_id == id}
  end


  def merchant_item(id)
    parent.merchant_item(id)
  end

end
