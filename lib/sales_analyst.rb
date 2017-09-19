require 'bigdecimal'
require 'pry'

require_relative 'math_extension'

class SalesAnalyst

  def initialize(sales_engine)
    @se = sales_engine
  end

  def average_items_per_merchant
    total_merchants = @se.merchants.all.count.to_f
    total_items = @se.items.all.count
    rounded(total_items / total_merchants)
  end

  def average_average_price_per_merchant
    rounded(
      Math.mean(@se.merchants.all) do |merchant|
        average_item_price(merchant)
      end
    )
  end

  def average_invoices_per_merchant
    merchants = @se.merchants.all.count.to_f
    invoices = @se.invoices.all.count
    rounded(invoices / merchants)
  end


  def average_item_price_for_merchant(id)
    merchant = @se.merchants.find_by_id(id)
    rounded average_item_price(merchant)
  end

  def average_item_price(merchant)
    Math.mean(merchant.items){ |item| item.unit_price }
  end

  def average_items_per_merchant_standard_deviation
    rounded(
      Math.standard_deviation(@se.merchants.all) do |merchant|
        merchant.items.count.to_f
      end
    )
  end

  def average_invoices_per_merchant_standard_deviation
    rounded(
      Math.standard_deviation(@se.merchants.all) do |merchant|
        merchant.invoices.count.to_f
      end
    )
  end

  def top_merchants_by_invoice_count
    Math.standard_deviations_above(2, @se.merchants.all) do |merchant|
      merchant.invoices.count.to_f
    end
  end

  def bottom_merchants_by_invoice_count
    Math.standard_deviations_above(-2, @se.merchants.all) do |merchant|
      merchant.invoices.count.to_f
    end
  end

  def average_invoice_count_per_day
    Math.mean(@se.invoices.all){ |invoice| invoice.created_at }
  end

  def invoices_by_day
    @se.invoices.all.each_with_object(Hash.new(0)) do |invoice, counts|
      day = invoice.created_at.strftime('%A')
      counts[day] += 1
    end
  end

  def top_days_by_invoice_count
    by_day = invoices_by_day
    top_counts = Math.standard_deviations_above(1, by_day.values)
    top_counts.map{ |count| by_day.key(count) }
  end

  def invoice_status(status)
    total = @se.invoices.all.count
    with_status = @se.invoices.all.count { |invoice| invoice.status == status }
    rounded (with_status * 100.0 / total)
  end

  def merchants_with_high_item_count
    Math.standard_deviations_above(1, @se.merchants.all) do |merchant|
      merchant.items.count.to_f
    end
  end

  def average_price_per_merchant_standard_deviation
    Math.standard_deviation(@se.merchants.all) do |merchant|
      average_item_price(merchant)
    end
  end

  def golden_items
    Math.standard_deviations_above(2, @se.items.all) do |item|
      item.unit_price
    end
  end

  def total_revenue_by_date(date)
    matching_invoices = @se.invoices.find_all do |invoice|
      invoice.created_at == date
    end

    matching_invoices.map(&:total).sum
  end

  def merchant_paid_item_invoices_by_item_id(merchant_id)
    merchant = @se.merchants.find_by_id(merchant_id)
    paid_invoices = merchant.invoices.select(&:is_paid_in_full?)
    iis = paid_invoices.flat_map(&:invoice_items)
    iis.group_by(&:item_id)
  end

  def best_item_for_merchant(merchant_id)
    item_invoices = merchant_paid_item_invoices_by_item_id(merchant_id)
    item_revenues = item_invoices.transform_values do |list|
      list.reduce(0) { |sum, ii| sum + ii.total }
    end
    best_id = item_revenues.max_by(&:last).first
    @se.items.find_by_id(best_id)
  end

  def most_sold_item_for_merchant(merchant_id)
    item_invoices = merchant_paid_item_invoices_by_item_id(merchant_id)
    item_revenues = item_invoices.transform_values do |list|
      list.reduce(0) { |sum, ii| sum + ii.quantity }
    end
    best_id = item_revenues.max_by(&:last).first
    @se.items.find_by_id(best_id)
  end

  def merchants_with_pending_invoices
    @se.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        invoice.transactions.none?(&:success?)
      end
    end
  end

  def merchants_with_only_one_item
    @se.merchants.find_all do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime('%B') == month_name
    end
  end

  def average_price
    Math.mean(@se.items.all) { |item| item.unit_price }
  end

  def revenue_by_merchant(merchant_id)
    @se.merchants.find_by_id(merchant_id).total_revenue
    # BigDecimal.new('3')
  end

  def top_revenue_earners(count = 20)
    merchants_ranked_by_revenue.first(count)
  end

  def merchants_ranked_by_revenue
    @se.merchants.all.sort_by{ |merchant| -merchant.total_revenue }
  end

  def rounded(answer)
    answer.round(2)
  end

end
