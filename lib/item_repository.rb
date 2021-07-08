require 'csv'
require_relative "item"

class ItemRepository
  attr_reader :all,
              :sales_engine

  def initialize(parent = nil)
    @all          = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def populate(filename)
     CSV.foreach(filename, headers: true,header_converters: :symbol) do |row|
      @all << Item.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id.to_i == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase.strip == name.downcase.strip
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
      price_range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id.to_i == merchant_id
    end
  end

  def find_merchant_by_id(merchant_id)
    @sales_engine.find_merchant_by_id(merchant_id)
  end

end
