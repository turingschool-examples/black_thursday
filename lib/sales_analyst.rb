# SalesAnalyst
require_relative 'sales_engine'
class SalesAnalyst

  attr_reader :merchant_repo,
              :item_repo

  def initialize(sales_engine)
    @merchant_repo = sales_engine.merchants
    @item_repo = sales_engine.items
  end

  def average_items_per_merchant
    (item_repo.items.count.to_f / merchant_repo.merchants.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    numbers_of_item = merchant_repo.merchants.map do |merchant|
      merchant.items.count
    end
    a = numbers_of_item.reduce(0) do |sum,number|
      sum + (number - average_items_per_merchant) ** 2
    end/(numbers_of_item.count - 1)
    Math.sqrt(a).round(2)
  end

  def merchants_with_high_item_count
    one_standard_deviation = average_items_per_merchant  + average_items_per_merchant_standard_deviation
    merchant_repo.merchants.map do |merchant|
    merchant if merchant.items.count > one_standard_deviation
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchant_repo.find_by_id(merchant_id)
    merchant.items.reduce(0) do |sum,item|
      sum + item.unit_price/merchant.items.length
    end.round(2)
  end
end
