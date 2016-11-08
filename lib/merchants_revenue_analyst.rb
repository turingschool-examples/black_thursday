require_relative 'statistics'
require_relative 'sales_engine'

class MerchantsRevenueAnalyst
  include Statistics

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def total_revenue_by_date(date)
    dated_invoice = engine.invoices.find_all_by_date(date)
    dated_invoice.reduce(0) do |sum, invoice|
      sum += invoice.total
      sum
    end
  end

  def top_revenue_earners(number = 20)
    sorted = merchants_ranked_by_revenue
    sorted[0..(number-1)]
  end

  def merchants_ranked_by_revenue
    invoice_ids = engine.invoices.all.group_by { |i| i.merchant_id }
    invoice_ids.each_key do |merchant_id|
      invoice_ids[merchant_id] = revenue_by_merchant(merchant_id)
    end
    sorted = sort_grouped(invoice_ids)
    sorted.map { |merchant_pair| engine.merchants.find_by_id(merchant_pair[0]) }
  end

  def revenue_by_merchant(merchant_id)
    invoices_by_merchant = engine.invoices.find_all_by_merchant_id(merchant_id)
    invoices_by_merchant.reduce(0) do |sum, invoice|
      sum += invoice.total
      sum
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    sorted = pull_merchants_sold_items(merchant_id)
    sorted.each_key do |item_id|
      sorted[item_id] = add_quantities(sorted[item_id])
    end
    final_sorted = sort_grouped(sorted)
    top_items = final_sorted.find_all {|el| el[1] == final_sorted[0][1]}
    top_items.map {|el| engine.items.find_by_id(el[0]) }
  end

  def sort_grouped(grouped)
    grouped.sort_by{|key, value| value}.reverse
  end

  def add_quantities(invoice_items)
    invoice_items.reduce(0) do |sum, ii|
      sum += ii.quantity
      sum
    end
  end

  def pull_merchants_sold_items(merchant_id)
    merchant_invoices = engine.merchants.find_by_id(merchant_id).invoices
    merchant_invoices = merchant_invoices.find_all { |i| i.is_paid_in_full? }
    sold_items = merchant_invoices.map { |i| i.invoice_items }.flatten
    sold_items.group_by { |ii| ii.item_id }
  end

  def reduce_revenue(invoice_items)
    invoice_items.reduce(0) do |sum, ii|
      sum += (ii.quantity * ii.unit_price)
      sum
    end
  end

  def best_item_for_merchant(merchant_id)
    sold_items = pull_merchants_sold_items(merchant_id)
    sold_items.each_key do |item_id|
      sold_items[item_id] = reduce_revenue(sold_items[item_id])
    end
    final_sorted = sort_grouped(sold_items)
    engine.items.find_by_id(final_sorted[0][0])
  end


end