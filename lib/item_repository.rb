require_relative 'item'
require 'bigdecimal'
require 'bigdecimal/util'
require 'csv'

class ItemRepository
  attr_reader :repository

  def initialize(data, sales_engine = nil)
    @sales_engine = sales_engine
    @repository   = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Item.new(data, self)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    if repository.keys.include?(id)
      return repository[id]
    end
  end

  def find_by_name(name)
    items = repository.values
    items.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    items = repository.values
    items.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    items = repository.values
    items.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    items = repository.values
    items.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |item|
      item.merchant_id == merch_id
    end
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |item|
      item.customer_id == customer_id
    end
  end

  def fetch_merchant(merchant_id)
    @sales_engine.fetch_merchant(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
