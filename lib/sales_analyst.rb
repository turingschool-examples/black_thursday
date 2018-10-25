require_relative 'statistics'
class SalesAnalyst
  include Statistics
  def initialize(items, merchants, invoices = nil)
    @items = items
    @merchants = merchants
    @invoices = invoices
  end

  def average_items_per_merchant
    (@items.all.size.to_f / @merchants.all.size).round(2)
  end
  def average_invoices_per_merchant
    (@invoices.all.size.to_f / @merchants.all.size).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_each_merchant = @items.all.group_by{|item|item.merchant_id}.map{|k,v|v.size}
    standard_deviation(*items_per_each_merchant).round(2)
  end

  def merchants_with_high_item_count
    temp_sd = average_items_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_items_of_merchant(merchant) > temp_sd + average_items_per_merchant
    end
  end

  def average_item_price_for_merchant(merchant_id)
    prices = @items.find_all_by_merchant_id(merchant_id).map(&:unit_price)
    average(*prices).to_f.round(2)
  end

  def average_average_price_per_merchant
    averages = @merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(*averages).round(2)
  end

  def golden_items
    item_prices = @items.all.map(&:unit_price)
    item_prices_std_dev = standard_deviation(*item_prices)
    average_item_price = average(*item_prices)
    @items.all.select do |item|
      item.unit_price > average_item_price + item_prices_std_dev * 2
    end
  end


  def num_items_of_merchant(merchant)
    @items.find_all_by_merchant_id(merchant.id).size
  end
end
