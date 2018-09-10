require_relative './merchant_repository'
require_relative './item_repository'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    (@se.items.all.count.to_f/@se.merchants.all.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    hash = Hash.new(0)
    @se.items.all.each do |item|
      hash[item.merchant_id] += 1
    end

  end

  def merchants_with_high_item_count

  end

  def average_item_price_for_merchant(merchant_id)

  end

  def average_average_price_per_merchant

  end

  def golden_items

  end


end
