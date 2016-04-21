require 'csv'
require_relative 'sales_engine'
require 'pry'

class SalesAnalysis
  attr_reader :engine

  def initialize(sales_engine)
    @engine = sales_engine
  end

  def average_items_per_merchant
    (items.all.count.to_f / @engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = find_merchant_ids.map do |id|
      items_by_merchant_id(id).size.to_f
    end
    num = merchant_items.map do |item_count|
      (item_count - average_items_per_merchant) ** 2
    end.reduce(:+) / (all_merchants.size - 1)
    deviation = Math.sqrt(num).round(2)
  end

  private

  def items
    engine.items
  end

  def merchants
    engine.merchants
  end

  def all_merchants
    merchants.all
  end

  def items_by_merchant_id(id)
    items.find_all_by_merchant_id(id)
  end

  def find_merchant_ids
    all_merchants.map {|merch| merch.id}
  end

end
