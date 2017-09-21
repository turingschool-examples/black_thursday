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
    all.select do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    all.select {|item| item.unit_price == price}
  end

  def find_all_by_price_in_range(price_range)
    all.select {|item| price_range.include?(item.unit_price)}
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|item| item.merchant_id.to_i == merchant_id}
  end

  def inspect
    "#<#{self.class} #{:items.size} rows>"
  end

end
