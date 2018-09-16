require 'csv'
require 'bigdecimal'
require 'time'

class SalesAnalyst
  def initialize(merchants, items, invoices, invoice_items, transactions, customers)
    @merchants = merchants
    @items = items
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
  end

  def average_items_per_merchant
    average_object_per_merchant(@items.all)
  end

  def average_items_per_merchant_standard_deviation
    average_object_per_merchant_std_dev(@items.all)
  end

  def merchants_with_high_item_count
    grouped_by_merchant_id = group_by_merch_id(@items.all)

    high_count_cutoff = (average_items_per_merchant_standard_deviation +
    average_items_per_merchant)

    high_count_merchants = []
    grouped_by_merchant_id.each do |merchant_id, items|
      if items.count > high_count_cutoff
        high_count_merchants << @merchants.find_by_id(merchant_id)
      end
    end
    high_count_merchants
  end

  def average_item_price_for_merchant(for_merchant_id)
    grouped_by_merchant_id = group_by_merch_id(@items.all)
     merchants_items = grouped_by_merchant_id[for_merchant_id]
     mimic_sum = merchants_items.inject(0.0) do |sum, item|
       sum + item.unit_price
     end
     (mimic_sum / merchants_items.count).round(2)
  end

  def average_average_price_per_merchant
    merchant_price_averages = @merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average(merchant_price_averages)
  end

  def golden_items
    item_prices = @items.all.map do |item|
      item.unit_price
    end

    sd_item_prices = standard_deviation(item_prices)
    average_price = average_average_price_per_merchant.to_f
    golden_item_cutoff = sd_item_prices * 2 + average_price

    golden_priced_items = []
    @items.all.each do |item|
      if item.unit_price > golden_item_cutoff
        golden_priced_items << item
      end
    end
    golden_priced_items
  end

  def average_invoices_per_merchant
    average_object_per_merchant(@invoices.all)
  end

  def average_invoices_per_merchant_standard_deviation
    average_object_per_merchant_std_dev(@invoices.all)
  end

  # 2 std dev above mean
  def top_merchants_by_invoice_count
    grouped_by_merchant_id = group_by_merch_id(@invoices.all)

    invoice_performance_cutoff = average_invoices_per_merchant_standard_deviation * 2 +
    average_invoices_per_merchant

    merchants_return_array = []
    grouped_by_merchant_id.each do |merchant_id, invoices|
      if invoices.count > invoice_performance_cutoff
        merchants_return_array << @merchants.find_by_id(merchant_id)
      end
    end
    merchants_return_array
  end

  # 2 std dev below mean
  def bottom_merchants_by_invoice_count
    grouped_by_merchant_id = group_by_merch_id(@invoices.all)

    invoice_performance_cutoff = average_invoices_per_merchant_standard_deviation * (-2) +
    average_invoices_per_merchant

    merchants_return_array = []
    grouped_by_merchant_id.each do |merchant_id, invoices|
      if invoices.count < invoice_performance_cutoff
        merchants_return_array << @merchants.find_by_id(merchant_id)
      end
    end
    merchants_return_array
  end

  def top_days_by_invoice_count
    invoice_day_hash = @invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end

    invoice_count_per_day = invoice_day_hash.map do |day, invoices|
      invoice_day_hash[day] = invoices.count
    end

    std_dev = standard_deviation(invoice_count_per_day)
    average = average(invoice_count_per_day)
    invoice_day_cutoff = std_dev + average

    top_days_by_invoice = []
    invoice_day_hash.each do |day, invoices_count|
      if invoices_count > invoice_day_cutoff
        top_days_by_invoice << day
      end
    end
    top_days_by_invoice
  end

  def invoice_status(status_symbol)
    invoice_status_hash = @invoices.all.group_by do |invoice|
      invoice.status.to_sym
    end

    invoice_count_for_status = invoice_status_hash[status_symbol].count.to_f

    invoices_for_status_fraction = (invoice_count_for_status / @invoices.all.count)

    (invoices_for_status_fraction * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    invoice_transactions = @transactions.find_all_by_invoice_id(invoice_id)
    return false if invoice_transactions == []
    @transactions.find_all_by_invoice_id(invoice_id).all? do |trans|
      trans.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_item_list = @invoice_items.find_all_by_invoice_id(invoice_id)
    invoice_item_list.reduce(BigDecimal("0")) do |total, invoice_item|
      item_total = invoice_item.unit_price * invoice_item.quantity

      total + item_total
    end
  end

  # helper method
  def group_by_merch_id(object_array)
    object_array.group_by do |object|
      object.merchant_id
    end
  end

  def average_object_per_merchant(object_array)
    grouped_by_merchant_id = group_by_merch_id(object_array)

    objects_per_merchant = grouped_by_merchant_id.values.map do |value|
      value.count
    end
    average(objects_per_merchant)
  end

  def average_object_per_merchant_std_dev(object_array)
    grouped_by_merchant_id = group_by_merch_id(object_array)
    object_per_merchant = grouped_by_merchant_id.values.map do |value|
      value.count
    end
    standard_deviation(object_per_merchant).round(2)
  end

  # end helpers

  # calculation helper methods

  def standard_deviation(integer_array)
    data_set_total = integer_array.inject(0.0) do |sum, num|
      sum + num
    end

    data_set_average = data_set_total / integer_array.count

    data_set_squared = integer_array.inject(0.0) do |sum, num|
      sum + (num - data_set_average) ** 2
    end

    Math.sqrt(data_set_squared / (integer_array.count - 1))
  end

  def average(integer_array)
    sum_of_data = integer_array.inject(0.0) do |sum, num|
      sum + num
    end
    (sum_of_data / integer_array.count).round(2)
  end

  # end calc helpers

end
