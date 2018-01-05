require 'ruby_native_statistics'
require 'bigdecimal'
require 'pry'
require_relative 'sales_engine'

class SalesAnalyst

  attr_reader :se,
              :average_item_prices

  def initialize(se)
    @se = se
    @average_item_prices = []
  end

  def average_items_per_merchant
    (se.grab_total_amount_of_items / se.grab_total_amount_of_merchants.to_f).round(2)
  end

  def number_of_items_per_merchant
    se.grab_array_of_merchant_items
  end

  def average_items_per_merchant_standard_deviation
    (number_of_items_per_merchant.stdev).round(2)
  end

  def merchants_with_high_item_count
    se.grab_merchants_with_high_items(self)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant           = se.find_merchant_by_id(merchant_id.to_s)
    items              = se.find_item_by_merchant_id(merchant_id.to_s)
    summed_item_prices = items.map { |item| item.unit_price.to_i }.sum
    BigDecimal.new(summed_item_prices / merchant.items.count)
  end

  def average_price_for_all_merchants
    merchants = se.grab_all_merchants
    summed_prices = merchants.map do |merchant|
      id = merchant.id
      average_item_price_for_merchant(id)
    end.sum
    BigDecimal.new(summed_prices / merchants.count)
  end

  def golden_items
    skip
    merchants = se.grab_all_merchants
    merchants.map do |merch|
      price = average_item_price_for_merchant(merch.id)
      if price >= (average_items_per_merchant_standard_deviation*2)
        se.find_item_by_merchant_id(merch.id)
        binding.pry
      end
    end
  end

end
