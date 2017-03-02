require_relative 'helper'

class SalesAnalyst

  include Calculator

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

#-----Navigation_Methods-----#

  def merchant_repository
    sales_engine.merchants
  end

  def all_merchants
    merchant_repository.all
  end

  def find_merchant_by_id(id)
    merchant_repository.find_by_id(id)
  end

  def find_merchant_items(id)
    find_merchant_by_id(id).items
  end

  def item_repository
    sales_engine.items
  end

  def all_items
    item_repository.all
  end

  def invoice_repository
    sales_engine.invoices
  end

  def all_invoices
    invoice_repository.all
  end

#-----/Navigation_Methods-----#

#-----Merchant_Analysis_Methods-----#

  def invoices_per_merchant
    merchant_repository.invoices_per_merchant
  end

  def count_items_per_merchant
     all_merchants.map do |merchant|
      merchant.items.length.to_f
    end
  end

  def average_items_per_merchant
    average(count_items_per_merchant)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(count_items_per_merchant)
  end

  def merchants_with_high_item_count
    one_sd = one_standard_deviation_above_mean(count_items_per_merchant)
    all_merchants.find_all do |merchant|
        merchant.items.length > one_sd
      end
  end

  def merchant_item_prices(id)
    find_merchant_items(id).map do |item|
      item.unit_price
    end
  end

  def average_item_price_for_merchant(id)
    average(merchant_item_prices(id))
  end

  def average_merchant_prices
    #please refactor me
    all_merchants.map do |merchant|
      id = merchant.id
      average_item_price_for_merchant(id)
    end
  end

  def average_average_price_per_merchant
    average(average_merchant_prices)
  end

  def paid_invoices_by_merchant(merchant)
    merchant.invoices.find_all {|invoice| invoice.is_paid_in_full? }
  end

  def revenue_by_invoices(invoices)
    invoices.reduce(0) do |sum, invoice|
      sum += invoice.total
    end
  end

  def merchant_revenue(merchant)
    invoices = paid_invoices_by_merchant(merchant)
    revenue_by_invoices(invoices)
  end

  def merchants_ranked_by_revenue
    all_merchants.sort_by do |merchant|
      merchant_revenue(merchant)
    end.reverse
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue.shift(x)
  end

  def revenue_by_merchant(merchant_id)
    merchant = merchant_repository.find_by_id(merchant_id)
    merchant_revenue(merchant)
  end

  def check_for_pending_invoices
    all_invoices.find_all { |invoice| !invoice.is_paid_in_full?}
  end

  def merchants_with_pending_invoices
    check_for_pending_invoices.map do |invoice|
      invoice.merchant
    end.uniq
  end

#-----/Merchant_Analysis_Methods-----#

#-----Item_Analysis_Methods-----#

  def all_item_prices
    all_items.map do |item|
      item.unit_price
    end
  end

  def average_item_price
    average(all_item_prices)  
  end

  def item_price_standard_deviation
    standard_deviation(all_item_prices)  
  end

  def golden_items
    two_sd = two_standard_deviations_above_mean(all_item_prices)
    all_items.find_all do |item|
      item.unit_price > two_sd
    end
  end

#-----/Item_Analysis_Methods-----#

#-----Invoice_Analysis_Method-----#

  def invoices_per_day
    invoice_repository.invoices_per_day
  end

  def invoices_per_day_values
    invoice_repository.invoices_per_day.values
  end

  def average_invoices_per_merchant
   average(invoices_per_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant)
  end

  def top_merchants_by_invoice_count
    two_sd = two_standard_deviations_above_mean(invoices_per_merchant)
    all_merchants.find_all do |merchant|
      merchant.invoices.length > two_sd
    end
  end

  def bottom_merchants_by_invoice_count
    two_sd = two_standard_deviations_below_mean(invoices_per_merchant)
    all_merchants.find_all do |merchant|
      merchant.invoices.length < two_sd
    end
  end

  def average_invoices_per_day
    average(invoices_per_day_values)
  end

  def top_days_by_invoice_count
    one_sd = one_standard_deviation_above_mean(invoices_per_day_values)
    days = []
    invoices_per_day.each do |key, value|
      if value > one_sd
        days << key
      end
    end
   days
  end

  def invoice_statuses
    all_invoices.map do |invoice|
      invoice.status
    end
  end

  def group_statuses
    invoice_statuses.group_by do |status|
      status
    end
  end

  def total_statuses
    all_invoices.count
  end

  def count_statuses
    groups = group_statuses
    groups.each_pair do |status, statuses|
      groups[status] = statuses.length
    end
  end

  def invoice_status(status)
    # returns percentage of total statuses
    percentage(count_statuses[status], total_statuses)
  end

  def total_revenue_by_date(date)
    invoice_repository.get_all_invoice_ids(date)
  end

#-----Invoice_Analysis_Method-----#

end