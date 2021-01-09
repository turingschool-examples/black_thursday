require 'csv'
require 'pry'
require 'descriptive_statistics'
require_relative './sales_engine'

class SalesAnalyst

  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    shops_items = engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.name] = []
      engine.items.all.each do |item|
        if item.merchant_id == merchant.id
          memo[merchant.name] << item.name
        end
      end
      memo
    end
    number_of_items = shops_items.map do |merchant, item|
      item.count
    end
    number_of_items.standard_deviation.round(2)
  end
end
