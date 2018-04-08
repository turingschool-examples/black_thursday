# frozen_string_literal: true

class SalesAnalyst
  attr_reader :sales_engine
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    all_items = list_of_number_of_items_per_merchant
    all_items.inject(:+).to_f / @sales_engine.merchants.all.length
  end

  def average_items_per_merchant_standard_deviation
    all_items = list_of_number_of_items_per_merchant
    average_items = average_items_per_merchant
    squared_num_items = all_items.map do |num_of_items|
      (num_of_items - average_items)**2
    end
    math = squared_num_items.inject(:+) / (all_items.length - 1)
    Math.sqrt(math)
  end

  def list_of_number_of_items_per_merchant
    @sales_engine.merchants.all.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant.id).items.length
    end
  end
end
