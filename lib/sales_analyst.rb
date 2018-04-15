require 'date'
require_relative 'analyzer'

# Sales Analyst class for analyzing data
class SalesAnalyst < Analyzer

  attr_reader :engine
  def initialize(sales_engine)
    super(sales_engine)
  end

  def average_items_per_merchant
    average(number_of_items, number_of_merchants).to_f
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(number_of_items_per_merchant.values, average_items_per_merchant)
  end

  def merchants_with_high_item_count
    threshold = average_items_per_merchant_plus_one_standard_deviation
    number_of_items_per_merchant.map do |id, num_of_items|
      @merchant_repo.find_by_id(id) if num_of_items >= threshold
    end.compact
  end

  def average_item_price_for_merchant(merchant_id)
    average(sum_of_item_price_for_merchant(merchant_id),
            number_of_items_per_merchant[merchant_id])
  end

  def average_average_price_per_merchant
    all_averages = @merchant_repo.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(all_averages.inject(:+), number_of_merchants)
  end

  def average_item_price_standard_deviation
    standard_deviation(@item_repo.items.values.map(&:unit_price).sort, average_item_price)
  end

  def golden_items
    threshold = average_item_price + (average_item_price_standard_deviation * 2)
    @item_repo.all.map do |item|
      item if item.unit_price >= threshold
    end.compact
  end

  def average_invoices_per_merchant
    average(number_of_invoices, number_of_merchants).to_f
  end

  def average_invoices_per_merchant_standard_deviation
    unique_merchants = @invoice_repo.all.map(&:merchant_id).uniq
    number_of_invoices_for_each_merchant = unique_merchants.map do |merchant_id|
      invoice_count(merchant_id)
    end
    standard_deviation(number_of_invoices_for_each_merchant,
                       average_invoices_per_merchant)
  end

  def average_invoices_per_day
    average(@invoice_repo.all.count,
            all_invoice_created_dates.uniq.count).to_f
  end

  def average_invoices_per_day_standard_deviation
    unique_days = @invoice_repo.all.map(&:created_at).uniq
    number_of_invoices_per_day = unique_days.map do |date|
      @invoice_repo.find_all_by_created_date(date).count
    end
    standard_deviation(number_of_invoices_per_day,
                       average_invoices_per_day)
  end

  def top_merchants_by_invoice_count
    top_merchant_ids = merchants_per_count.map do |count, merchant_ids|
      merchant_ids if count >= average_invoices_per_merchant_plus_two_standard_deviations
    end.flatten.compact

    top_merchant_ids.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    top_merchant_ids = merchants_per_count.map do |count, merchant_ids|
      merchant_ids if count <= average_invoices_per_merchant_minus_two_standard_deviations
    end.flatten.compact

    top_merchant_ids.map do |merchant_id|
      @merchant_repo.find_by_id(merchant_id)
    end
  end

  def top_days_by_invoice_count
    threshold = average_invoices_per_weekday_plus_one_standard_deviation
    number_of_invoices_by_weekday.map do |weekday, number|
      weekday.capitalize if number > threshold
    end.compact
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @transaction_repo.find_all_by_invoice_id(invoice_id)
    return false if transactions.empty?
    transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @invoice_item_repo.find_all_by_invoice_id(invoice_id)
    invoice_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end.reduce(:+)
  end


  def paid_invoice_filter
    customer_invoice_ids = invoices_per_customer
    paid_invoices_by_customer = {}
    customer_invoice_ids.each do |customer_id, invoices|
      paid_invoices = invoices.find_all do |invoice|
        invoice if invoice_paid_in_full?(invoice.id)
      end
      paid_invoices_by_customer[customer_id] = paid_invoices
    end

    paid_invoices_by_customer.delete_if do |customer_id, invoice_results|
      invoice_results.empty?
    end
    paid_invoices_by_customer
  end

  def invoice_totals_by_customer
    paid_invoices = paid_invoice_filter
    invoice_totals_by_customer = {}
    paid_invoices.each do |customer_id, invoices|
      invoice_totals = invoices.map do |invoice|
        invoice_total(invoice.id)
      end
      invoice_totals_by_customer[customer_id] = invoice_totals.reduce(:+)
    end
    invoice_totals_by_customer
  end
  
  def top_buyers(list_length = 20)
    # --- invoice_total, add total to customer total.
    # Sum the totals and compare to each other.
    # sort by max
    result = invoice_totals_by_customer
    # require 'pry';binding.pry
  
    # top_customer_ids.map do |customer_id|
    #   @customer_repo.find_by_id(customer_id)
    # end
  end

  # def best_invoice_by_quantity
  #   highest_quantity = invoice_items.map(&:quantity).reduce(:+)
  #   # best_invoice = highest_quantity.each
  # end
end
