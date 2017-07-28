require_relative 'sales_engine'
require_relative 'stats'

class SalesAnalyst
  include Stats
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    (se.all_items.count.to_f / se.all_merchants.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(num_items_per_merchant).round(2)
  end

  def merchants_with_high_item_count
    bar = one_standard_deviation_bar
    high_sell = []
    high_selling_merchants.each do |merchant, item_amt|
      high_sell << merchant if item_amt > bar
    end
    high_sell
  end

  def average_item_price_for_merchant(id)
    average(merchant_items_prices(id))
  end

  def average_average_price_per_merchant
    avg = []
    merchant_id_item_group.each do |key,value|
      avg << value.map {|item| item.unit_price}.reduce(:+) / value.count
    end
    average(avg)
  end

  def golden_items
    gold = []
    se.all_items.map do |item|
      if item.unit_price > two_std_dev(item_prices)
        gold << item
      end
    end
    gold
  end

end
