require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'item'
require_relative 'merchant'
# require "./lib/sales_engine"
require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'
class SalesAnalyst < SalesEngine

  def initialize(items_path,merchants_path)
    super
  end
  # binding.pry
  def average_items_per_merchant
    (@items.all.count / @merchants.all.count.to_f).round(2)
  end

  # def average_items_per_merchant_standard_deviation
  #
  # end

  def average_item_price_for_merchant(id)
    item_count = @items.find_all_by_merchant_id(id).count
    total_prices = []
    @items.find_all_by_merchant_id(id).each do |item|
      total_prices << item.unit_price_to_dollars
    end
    BigDecimal((total_prices.sum/item_count).round(2).to_s)
  end

  def average_average_price_per_merchant
  all_merchants = []
  @merchants.all.each {|merchant| all_merchants << merchant.id}
  unique_merchants = all_merchants.uniq.count
  all_merchants.map! {|merchant_id| average_item_price_for_merchant(merchant_id)}
  BigDecimal((all_merchants.sum / unique_merchants).round(2).to_s)
  end

end
