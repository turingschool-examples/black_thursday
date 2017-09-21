require 'bigdecimal'

require_relative 'stats'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    total_merchants = @se.merchants.count.to_f
    total_items = @se.items.count
    rounded(total_items / total_merchants)
  end

  def average_invoices_per_merchant
    merchants = @se.merchants.count.to_f
    invoices = @se.invoices.count
    rounded(invoices / merchants)
  end

  def average_price
    Stats.mean(@se.items, &:unit_price)
  end

  def average_item_price_for_merchant(id)
    rounded @se.merchants.find_by_id(id).average_item_price
  end

  def average_average_price_per_merchant
    rounded Stats.mean(@se.merchants, &:average_item_price)
  end

  def average_items_per_merchant_standard_deviation
    rounded Stats.standard_deviation(@se.merchants, &:item_count)
  end

  def average_invoices_per_merchant_standard_deviation
    rounded Stats.standard_deviation(@se.merchants, &:invoice_count)
  end

  def top_merchants_by_invoice_count
    Stats.standard_deviations_from_mean(2, @se.merchants, &:invoice_count)
  end

  def bottom_merchants_by_invoice_count
    Stats.standard_deviations_from_mean(-2, @se.merchants, &:invoice_count)
  end

  def invoices_by_day
    @se.invoices.each_with_object(Hash.new(0)) do |invoice, counts|
      day = invoice.created_at.strftime('%A')
      counts[day] += 1
    end
  end

  def top_days_by_invoice_count
    by_day = invoices_by_day
    top_counts = Stats.standard_deviations_from_mean(1, by_day.values)
    top_counts.map{ |count| by_day.key(count) }
  end

  def invoice_status(status)
    total = @se.invoices.count
    with_status = @se.invoices.count { |invoice| invoice.status == status }
    rounded (with_status * 100.0 / total)
  end

  def merchants_with_high_item_count
    Stats.standard_deviations_from_mean(1, @se.merchants, &:item_count)
  end

  def golden_items
    Stats.standard_deviations_from_mean(2, @se.items, &:unit_price)
  end

  def total_revenue_by_date(date)
    matching_invoices = @se.invoices.select do |invoice|
      invoice.created_at == date
    end
    matching_invoices.map(&:total).sum
  end

  def paid_invoice_items(merchant_id)
    merchant = @se.merchants.find_by_id(merchant_id)
    paid_invoices = merchant.invoices.select(&:is_paid_in_full?)
    paid_invoices.flat_map(&:invoice_items)
  end

  def scores_by_item_id(merchant_id, &score_method)
    by_item = paid_invoice_items(merchant_id).group_by(&:item_id)
    by_item.transform_values do |invoice_items|
      invoice_items.map(&score_method).sum
    end
  end

  def best_item_for_merchant(merchant_id)
    revenues = scores_by_item_id(merchant_id, &:total)
    top_revenue = revenues.values.max
    best_item_id = revenues.key(top_revenue)
    @se.items.find_by_id(best_item_id)
  end

  def most_sold_item_for_merchant(merchant_id)
    quantities = scores_by_item_id(merchant_id, &:quantity)
    top_quantity = quantities.values.max
    quantities.keep_if{ |item_id, quantity| quantity == top_quantity }
    quantities.keys.map{ |item_id| @se.items.find_by_id(item_id) }
  end

  def merchants_with_pending_invoices
    @se.merchants.reject do |merchant|
      merchant.invoices.all?(&:is_paid_in_full?)
    end
  end

  def merchants_with_only_one_item
    @se.merchants.select { |merchant| merchant.item_count == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.strftime('%B') == month_name
    end
  end

  def revenue_by_merchant(merchant_id)
    @se.merchants.find_by_id(merchant_id).total_revenue
  end

  def top_revenue_earners(count = 20)
    merchants_ranked_by_revenue.first(count)
  end

  def merchants_ranked_by_revenue
    @se.merchants.sort_by{ |merchant| -merchant.total_revenue }
  end

  def rounded(answer)
    answer.round(2)
  end

end
