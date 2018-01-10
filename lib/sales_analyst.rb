require 'bigdecimal'
require_relative "calculator"

class SalesAnalyst
  include Calculator
  def initialize(sales_engine = "")
    @se = sales_engine
  end

  def item_count_array_maker
    @se.all_merchants.map do |merchant|
      item_counter(merchant.id)
    end
  end

  def average_items_per_merchant
    sum = item_count_array_maker.sum
    length = item_count_array_maker.count
    average(sum, length).round(2)
  end

  def item_counter(id = 0)
    num = @se.items.find_all_by_merchant_id(id).count
    @se.assign_item_count(id, num)
    num
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    square = item_count_array_maker.map do |item|
      (item-mean) ** 2
    end.sum
    sqrt(square/(item_count_array_maker.length-1)).round(2)
  end

  def mean_plus_standard_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    base_line = mean_plus_standard_deviation
    @se.all_merchants.select do |merchant|
      merchant.item_count > base_line
    end
  end

  def average_item_price_for_merchant(id)
    sum = merchant_items_sum(id)
    length = @se.items.find_all_by_merchant_id(id).length
    average(sum, length).round(2)
  end

  def merchant_items_sum(id)
    @se.items.find_all_by_merchant_id(id).reduce(0) do |sum, item|
      sum += item.unit_price
    end
  end

  def average_price_per_merchant_array_maker
    @se.all_merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def average_price_per_merchant_sum
    average_price_per_merchant_array_maker.sum
  end

  def average_average_price_per_merchant
    sum = average_price_per_merchant_sum
    length = average_price_per_merchant_array_maker.count
    average(sum, length).floor(2)
  end

  def price_standard_deviation
    mean = average_average_price_per_merchant
    square = @se.all_items.map do |item|
      (item.unit_price - mean) ** 2
    end.sum
    sqrt(square/(@se.all_items.length-1)).floor(2)
  end

  def golden_items
    baseline = average_average_price_per_merchant + price_standard_deviation * 2
    @se.all_items.select do |item|
      item.unit_price > baseline
    end
  end

  def count_invoices
    @se.all_invoices.count.to_f
  end

  def count_merchants
    @se.all_merchants.count.to_f
  end

  def invoice_array_maker
    @se.all_merchants.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant
    sum = count_invoices
    length = count_merchants
    average(sum, length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    square = invoice_array_maker.map do |invoice|
      (invoice-mean) ** 2
    end.sum
    sqrt(square/(invoice_array_maker.length-1)).round(2)
  end

  def top_merchant_by_invoice_baseline
    mean = average_invoices_per_merchant
    double_deviation = average_invoices_per_merchant_standard_deviation*2
    mean + double_deviation
  end

  def top_merchants_by_invoice_count
    base_line = top_merchant_by_invoice_baseline
    @se.all_merchants.select do |merchant|
      merchant.invoices.count > base_line
    end
  end

  def bottom_merchants_by_invoice_baseline
    mean = average_invoices_per_merchant
    double_deviation = average_invoices_per_merchant_standard_deviation*2
    mean - double_deviation
  end

  def bottom_merchants_by_invoice_count
    base_line = bottom_merchants_by_invoice_baseline
    @se.all_merchants.select do |merchant|
      merchant.invoices.count < base_line
    end
  end

  def created_at_day_hash_maker
    @se.all_invoices.group_by do |invoice|
      invoice.created_at.wday
    end
  end

  def created_at_day_counter
    created_at_day_hash_maker.transform_values do |value|
      value.count
    end
  end

  def created_at_day_mean
    sum = created_at_day_counter.values.sum
    length = created_at_day_counter.values.length
    average(sum, length)
  end

  def created_at_standard_deviation
    mean = created_at_day_mean
    square = created_at_day_hash_maker.map do |day, invoice_array|
      (invoice_array.count - mean) ** 2
    end.sum
    sqrt(square/(created_at_day_hash_maker.length-1)).round(2)
  end

  def top_days_by_invoice_count
    base_line = created_at_day_mean + created_at_standard_deviation
    days = created_at_day_hash_maker.select do |day, invoice_array|
      invoice_array.count > base_line
    end.keys
    days.map do |day|
      DAYS[day]
    end
  end

  def invoices_by_status(status)
    @se.all_invoices.select do |invoice|
      invoice.status == status
    end
  end

  def invoice_status(status)
    ((invoices_by_status(status).length / count_invoices) * 100).round(2)
  end

  def total_revenue_by_date(date)
    @se.find_invoices_by_date(date).reduce(0) do |sum, invoice|
      sum += invoice.total
    end
  end

  def merchants_ranked_by_revenue
    @se.all_merchants.map do |merchant|
      @se.assign_total_revenue(merchant.id, revenue_by_merchant(merchant.id))
    end

    @se.all_merchants.sort_by do |merchant|
      0 - merchant.total_revenue
    end
  end

  def top_revenue_earners(num = 20)
    merchants_ranked_by_revenue[0..num-1]
  end

  def merchants_with_pending_invoices
    invoices = @se.find_pending_invoices

    invoices.map do |invoice|
      invoice.merchant
    end.uniq
  end

  def merchants_with_only_one_item
    @se.all_merchants.select do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_by_month(month).select do |merchant|
      merchant.item_count == 1
    end
  end

  def merchants_by_month(month)
    @se.all_merchants.select do |merchant|
      if merchant.created_at[5..6] == MONTHS[month.downcase]
        @se.assign_item_count(merchant.id, merchant.items.count)
      end
    end
  end

  def revenue_by_merchant(id)
    BigDecimal.new(@se.find_invoice_by_merchant_id(id).reduce(0) do |sum, inv|
      if inv.is_paid_in_full?
        sum += inv.total
      else
        sum += 0
      end
    end / 100.0, 6)
  end

  def most_sold_item_for_merchant(id)
    paid = @se.find_invoice_by_merchant_id(id).select do |invoice|
      invoice.is_paid_in_full?
    end

    invoice_items = paid.map do |invoice|
      invoice.invoice_items
    end.flatten

    grouped_invoice_items = invoice_items.group_by do |invoice_item|
      invoice_item.item_id
    end

    transformed = grouped_invoice_items.transform_values do |value|
      value.map do |invoice_item|
        invoice_item.quantity
      end
    end

    item_id_and_quantity = transformed.sort_by do |pair|
      pair.flatten![1]
    end

    quantity_hash = item_id_and_quantity.group_by do |value|
      value[1]
    end

    item_ids = quantity_hash.values.last.map do |item_id|
        item_id[0]
    end

    item_ids.map do |item_id|
      @se.find_item_by_id(item_id)
    end
  end

  def best_item_for_merchant(id)
    invoice_items = @se.find_invoice_by_merchant_id(id).map do |iv|
      iv.invoice_items if iv.is_paid_in_full?
    end.compact.flatten

    most_sold = invoice_items.sort_by do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end.last

    @se.find_item_by_id(most_sold.item_id)
  end
end
