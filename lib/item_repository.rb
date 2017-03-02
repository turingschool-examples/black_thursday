require 'csv'
require_relative 'repository'
require_relative 'item'
require 'bigdecimal'

class ItemRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, Item)
  end

  def all
    data
  end

  def count
    data.count
  end

  def find_by_id(id)
    data.select { |item| item.id == id }.first
  end

  def find_by_name(name)
    data.select { |item| item.name.downcase == name.downcase }.first
  end

  def find_all_with_description(descript)
    data.select { |item| item.description.downcase.include?(descript.downcase) }
  end

  def find_all_by_price(price)
    data.select { |item| item.unit_price == price }
  end

  def find_all_by_price_in_range(range)
    min_range = range.first
    max_range = range.last

    data.select do |item|
      item.unit_price >= min_range && item.unit_price <= max_range
    end
  end

  def find_all_by_merchant_id(merchant_id)
    data.select { |item| item.merchant_id == merchant_id }
  end
end
