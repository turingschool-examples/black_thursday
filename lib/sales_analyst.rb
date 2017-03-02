require 'date'
require_relative 'statistics'

class SalesAnalyst
  include Statistics

  attr_reader :engine,
              :merchant_items_set,
              :total_prices,
              :price_set,
              :invoice_set,
              :invoices_by_date,
              :merchants_by_revenue,
              :merchants_pending,
              :merchants_one_item

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    average(merchant_items_set)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchant_items_set)
  end

  def merchants_with_high_item_count
    merchants.select do |merchant|
      merchant.items.count > top_threshold(merchant_items_set, 1)
    end
  end

  def average_item_price_for_merchant(merch_id)
    items_by_merchant = engine.merchants.find_by_id(merch_id).items
    average(items_by_merchant.map { |item| item.unit_price })
  end

  def average_average_price_per_merchant
    total_avgs ||= merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    average(total_avgs)
  end

  def average_item_price
    average(price_set)
  end

  def item_price_standard_deviation
    standard_deviation(price_set)
  end

  def golden_items
    prices_top_threshold ||= top_threshold(price_set, 2)
    items.select do |item|
      item.unit_price_to_dollars > prices_top_threshold
    end
  end

  def average_invoices_per_merchant
    average(invoice_set)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoice_set)
  end

  def top_merchants_by_invoice_count
    top_threshold_invoices ||= top_threshold(invoice_set, 2)
    merchants.select do |merchant|
      merchant.invoices.count > top_threshold_invoices
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_threshold_invoices ||= bottom_threshold(invoice_set, 2)
    merchants.select do |merchant|
      merchant.invoices.count < bottom_threshold_invoices
    end
  end

  def invoice_days
    invoices.map { |invoice| invoice.created_at.strftime('%A')}
  end

  def invoices_by_day
    invoice_days.reduce(Hash.new(0)) do |total, day|
      total[day] = 0 if total[day].nil?
      total[day] += 1
      total
    end
  end

  def invoices_by_day_average
    average(invoices_by_day.values)
  end

  def invoices_by_day_standard_deviation
    standard_deviation(invoices_by_day.values)
  end

  def top_days_by_invoice_count
    invoices_by_day.keys.select do |day|
      invoices_by_day[day] > top_threshold(invoices_by_day.values, 1)
    end
  end

  def invoice_status(status)
    find_all_by_status = engine.invoices.find_all_by_status(status)
    ((find_all_by_status.count / invoices.count.to_f) * 100).round(2)
  end

  def total_revenue_by_date(date)
    @invoices_by_date ||= invoices.select do |invoice|
      invoice.created_at == date
    end
    invoices_by_date.map do |invoice|
      invoice.total
    end.reduce(:+)
  end

  def revenue_by_merchant(merch_id) # private
    engine.merchants.find_by_id(merch_id).revenue
  end

  def merchants_ranked_by_revenue
    @merchants_by_revenue ||= merchants.sort_by do |merchant|
      [merchant.revenue ? 1 : 0, merchant.revenue]
    end.reverse
  end

  def top_revenue_earners(num_top = 20)
    merchants_ranked_by_revenue[0..num_top-1]
  end

  def merchants_with_pending_invoices
    @merchants_pending ||= merchants.select do |merchant|
      merchant.any_pending?
    end
  end

  def merchants_with_only_one_item
    @merchants_one_item ||= merchants.select do |merchant|
      merchant.only_one_item?
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def paid_merchant_invoices(merchant_id) # private
    merchant = engine.merchants.find_by_id(merchant_id)
    merchant.invoices.map do |invoice|
      invoice.invoice_items if invoice.is_paid_in_full?
    end.flatten.compact
  end

  def quantity_of_item(merchant_id) # private
    paid_merchant_invoices(merchant_id).reduce({}) do |memo, invoice_item|
      memo[invoice_item] = invoice_item.quantity
      memo
    end
  end

  def quantity_sorted(merchant_id)
    quantity_of_item(merchant_id).max_by do |invoice_item, quantity|
      quantity
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    top = quantity_of_item(merchant_id).select do |item_id, quantity|
      quantity == quantity_sorted(merchant_id)[1]
    end
    top.keys.map{|item| engine.items.find_by_id(item.item_id)}
  end

  def item_revenue_for_merchant(merchant_id) # private
    paid_merchant_invoices(merchant_id).reduce({}) do |memo, invoice_item|
      memo[invoice_item] = invoice_item.quantity * invoice_item.unit_price
      memo
    end
  end

  def revenue_sorted(merchant_id)
    rs=item_revenue_for_merchant(merchant_id).max_by do |invoice_item, revenue|
      revenue
    end
    rs.pop
    rs
  end

  def best_item_for_merchant(merchant_id)
    revenue_sorted(merchant_id).map do |item|
      engine.items.find_by_id(item.item_id)
    end.first
  end

  private

  def items
    engine.items.all
  end

  def merchants
    engine.merchants.all
  end

  def invoices
    engine.invoices.all
  end

  def merchant_items_set
    @merchant_items_set ||= merchants.map{ |merchant| merchant.items.count }
  end

  def price_set
    @price_set ||= items.map { |item| item.unit_price_to_dollars}
  end

  def invoice_set
    @invoice_set ||= merchants.map{|merchant| merchant.invoices.count}
  end

end
