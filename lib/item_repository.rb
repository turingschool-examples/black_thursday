require_relative 'item'
require_relative 'sales_engine'
require 'csv'

class ItemRepository

  attr_reader :all, :items, :sales_engine

  def initialize(sales_engine, item_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      all << Item.new(self, row)
    end
  end

  def find_by_id(id)
    all.each do |item|
      return item if item.id.to_i == id
    end
    nil
  end

  def find_by_name(name)
    all.each do |item|
      return item if item.name.downcase == name.downcase
    end
    nil
  end

  def find_all_with_description(description)
    item_array = []
    all.each do |item|
      item_array << item if item.description.downcase.include?(description.downcase)
    end
    item_array
  end

  def find_all_by_price(price)
    item_array = []
    all.each do |item|
      item_array << item if item.unit_price == price
    end
    # binding.pry
    item_array
  end

  def find_all_by_price_in_range(price_range)
    item_array = []
    all.each do |item|
      if price_range.include?(item.unit_price)
        item_array << item
      end
    end
    item_array
  end

  def find_all_by_merchant_id(merchant_id)
  merchant_id_array = []
  all.each do |item|
    if item.merchant_id.to_i == merchant_id
      merchant_id_array << item
    end
  end
    return merchant_id_array
  end

  def inspect
    "#<#{self.class} #{:items.size} rows>"
  end

end
