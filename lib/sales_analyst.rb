require_relative 'sales_engine'
require          'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    number_of_merchants = se.merchants.all.count
    items_per_merchant = se.merchants.all.map {|merchant| merchant.items.count}

    (items_per_merchant.inject(0.0) {|sum, items| sum + items} / number_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation

  end

  def merchants_with_low_item_count

  end

  def average_item_price_for_merchant

  end

  def average_price_per_merchant

  end

  def golden_items

  end
end
