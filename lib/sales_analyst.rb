require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'

class SalesAnalyst

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    number_of_merchants = @se.merchants.all.count
    number_of_items = @se.items.all.count
    (number_of_items.to_f/number_of_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    number_of_merchants = @se.merchants.all.count
    count_of_each_merchant_item =
    @se.merchants.all.map do |merchant|
      merchant.items.count
    end
    difference_between_mean_and_count_squared =
    count_of_each_merchant_item.map do |num|
      (average_items_per_merchant - num)**2
    end
    summed_differences = difference_between_mean_and_count_squared.reduce(:+)
    amount_less_one = count_of_each_merchant_item.count - 1
    Math.sqrt(summed_differences.to_f/amount_less_one).round(2)
  end

  def merchants_with_high_item_count
    high_sellers = []
    average = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    @se.merchants.all.each do |merchant|
      if merchant.items.count > (average + (1*standard_deviation))
        high_sellers << merchant
      end
    end
    high_sellers
  end

  def average_item_price_for_merchant(merchant_id)
    total_item_count = @se.merchants.find_by_id(merchant_id).items.count
    price_array = []
    @se.merchants.find_by_id(merchant_id).items.each do |item|
      price_array << item.price
    end
    total_price = price_array.reduce(:+)
    average_price = total_price / total_item_count
    BigDecimal.new(average_price / 100).round(2)
  end

  def average_average_price_per_merchant
    array = []
    @se.merchants.all.each do |merchant|
      # binding.pry
      array << self.average_item_price_for_merchant(merchant.id)
    end
    BigDecimal.new(array.reduce(:+) / array.count).round(2)
  end

  def find_standard_deviation_of_average_item_price
    amount_of_items = @se.items.all.count
    average_price_of_items = self.average_average_price_per_merchant
    prices = []
    @se.items.all.each do |item|
      prices << ((item.price - average_price_of_items)**2)
    end
    summed_prices = (prices.reduce(:+)/(amount_of_items - 1))
    Math.sqrt(summed_prices).round(2)
  end

  def golden_items
    golden_items = []
    average = average_average_price_per_merchant
    standard_deviation = find_standard_deviation_of_average_item_price
    @se.items.all.each do |item|
      if item.price > (average+(2*standard_deviation))
        golden_items << item
      end
    end
    golden_items
  end

  def average_invoices_per_merchant
    (@se.invoices.all.count.to_f / @se.merchants.all.count).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    number_of_invoices = @se.invoices.all.count
    count_of_each_merchant_invoice =
    @se.merchants.all.map do |merchant|
      merchant.invoices.count
    end
    difference_between_mean_and_count_squared =
    count_of_each_merchant_invoice.map do |num|
      (average_invoices_per_merchant - num)**2
    end
    summed_differences = difference_between_mean_and_count_squared.reduce(:+)
    amount_less_one = count_of_each_merchant_invoice.count - 1
    Math.sqrt(summed_differences.to_f/amount_less_one).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    @se.merchants.all.each do |merchant|
      if merchant.invoices.count > (average + (2*standard_deviation))
        top_merchants << merchant
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    @se.merchants.all.each do |merchant|
      if merchant.invoices.count < (average - (2*standard_deviation))
        bottom_merchants << merchant
      end
    end
    bottom_merchants
  end

  def top_days_by_invoice_count
    high_inv_days(day_array, ave_invoice_per_day, invoice_std_dev(inv_per_day))
  end

  def invoice_std_dev(inv_per_day)
    array =
    inv_per_day.each do |total|
      (total - ave_invoice_per_day)**2
    end
    Math.sqrt(array.reduce(:+) / 7).round
  end

  def inv_per_day
    grouped_invoices.values.map(&:length)
  end

  def day_array
    grouped_invoices.keys.zip(inv_per_day)
  end

  def high_inv_days(day_array, ave_invoice_per_day, invoice_std_dev)
    day_array.select do |invoice|
      invoice[1] > (ave_invoice_per_day + invoice_std_dev)
    end.map { |value| value[0] }
  end

  def grouped_invoices
    @se.invoices.all.group_by { |invoice| invoice.created_at.strftime("%A") }
  end

  def ave_invoice_per_day
    @se.invoices.all.length / 7
  end

  def invoice_status(status)
    status_count = @se.invoices.find_all_by_status(status).count
    total_count = @se.invoices.all.count
    ((status_count.to_f / total_count)*100).round(2)
  end

  def total_revenue_by_date(date)
    invoices_for_date = @se.invoices.all.select { |i| i.created_at == date }
    invoices_for_date.reduce(0) { |sum, i| sum += i.total }
  end

  def top_revenue_earners(x=20)
    grouped_by_ii = paid_invoices.group_by { |t| t.merchant_id }
    grouped_by_ii.each_value do |invoice|
      invoice.map! { |i| i.total }
    end
    totals = grouped_by_ii.keys.sort_by do |merch_id|
      grouped_by_ii[merch_id].reduce(:+)
    end
    top_merchants = totals.map do |merch|
      @se.merchants.find_by_id(merch)
    end
    top_merchants.reverse[0..x-1]
  end

  def paid_invoices
    @se.invoices.all.select { |i| i.is_paid_in_full? }
  end

  def unpaid_invoices
    @se.invoices.all.select { |i| !i.is_paid_in_full? }
  end

  def merchants_ranked_by_revenue
    @se.merchants_by_total_revenue
  end

  def revenue_by_merchant(merchant_id)
    @se.revenue_by_merchant(merchant_id)
  end

  def merchants_with_pending_invoices
    @se.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        invoice.transactions.all? do |transaction|
          transaction.result == "failed"
        end
      end
    end
  end

  def merchants_with_only_one_item
    @se.merchants.all.select { |merchant| merchant.items.count == 1 }
  end

end
