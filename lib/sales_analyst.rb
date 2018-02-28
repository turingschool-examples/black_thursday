require_relative 'analytics_module'

# Business metadata calculator
class SalesAnalyst
  include Analytics

  def initialize(sales_eng)
    @se = sales_eng
  end

  def average_items_per_merchant
    average(items_for_each_merchant)
  end

  def items_for_each_merchant
    @se.merchants.all.map do |merchant|
      merchant.items.length.to_f
    end
  end

  def average_items_per_merchant_standard_deviation
    item_counts = items_for_each_merchant
    standard_deviation(item_counts, average(item_counts))
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    st_dev = average_items_per_merchant_standard_deviation
    one_sigma = average + st_dev
    @se.merchants.all.find_all do |merchant|
      merchant.items.length > one_sigma
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @se.merchants.find_by_id(merchant_id)
    item_prices = merchant.items.map(&:unit_price)
    average(item_prices)
  end

  def total_avg_price
    @se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end.reduce(:+)
  end

  def average_average_price_per_merchant
    (total_avg_price / @se.merchants.all.length).round(2)
  end

  def all_item_prices
    @se.items.all.map(&:unit_price)
  end

  def golden_items
    average = average(all_item_prices)
    st_dev = standard_deviation(all_item_prices, average)
    two_sigma = average + (2 * st_dev)
    @se.items.all.find_all do |item|
      item.unit_price > two_sigma
    end
  end

  def invoices_for_each_merchant
    @se.merchants.all.map do |merchant|
      merchant.invoices.length.to_f
    end
  end

  def average_invoices_per_merchant
    average(invoices_for_each_merchant)
  end

  def average_invoices_per_merchant_standard_deviation
    invoice_counts = invoices_for_each_merchant
    standard_deviation(invoice_counts, average(invoice_counts))
  end

  def top_merchants_by_invoice_count
    merchants = @se.merchants.all
    avg_invc = average_invoices_per_merchant
    st_dev = average_invoices_per_merchant_standard_deviation
    two_sigma = avg_invc + (2 * st_dev)
    top_merchants = []
    merchants.find_all do |merchant|
      if merchant.invoices.length > two_sigma
        top_merchants << merchant.id
      end
    end
  end

  def bottom_merchants_by_invoice_count
    merchants = @se.merchants.all
    avg_invc = average_invoices_per_merchant
    st_dev = average_invoices_per_merchant_standard_deviation
    two_sigma = avg_invc - (2 * st_dev)
    top_merchants = []
    merchants.find_all do |merchant|
      if merchant.invoices.length < two_sigma
        top_merchants << merchant.id
      end
    end
  end

  def top_days_by_invoice_count
    invoices = @se.invoices.all
    top_days = invoices.reduce({}) do |results, invoice|
	     day = invoice.created_at.strftime("%A")
       results[day] = 0 if results[day].nil?
	     results[day] += 1
	     results
      end
      avg_by_day = average(top_days.values)
      std_by_day = standard_deviation(top_days.values, avg_by_day)
      sigma = std_by_day + avg_by_day
      shit = top_days.map do |day, revenue|
        day if revenue > sigma
      end.compact
  end

  def invoice_status(status)
    invoices = @se.invoices.all.find_all do |invoice|
      invoice.status == status
    end
    percent = (invoices.length / @se.invoices.all.length.to_f) * 100
    percent.round(2)
  end

end
