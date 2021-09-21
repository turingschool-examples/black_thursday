require 'csv'
require 'bigdecimal'
require_relative 'sales_engine'

class SalesAnalyst
  def initialize(repos)
    @items         = repos[:items]
    @merchants     = repos[:merchants]
    @invoices      = repos[:invoices]
    @invoice_items = repos[:invoice_items]
    @transactions  = repos[:transactions]
  end

  def average_items_per_merchant
    (@items.all.length.to_f/@merchants.all.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    sum = @merchants.all.sum do |merchant|
      (@items.find_all_by_merchant_id(merchant.id).length.to_f - mean)**2
    end

    Math.sqrt(sum / (@merchants.all.length.to_f - 1)).round(2)
  end

  def merchants_with_high_item_count
    mean = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      mean + std_dev < @items.find_all_by_merchant_id(merchant.id).length
    end
  end

  def average_item_price_for_merchant(id)
    items = @items.find_all_by_merchant_id(id)

    sum = items.sum do |item|
      item.unit_price
    end

    BigDecimal((sum / items.length.to_f).round(2))
  end

  def average_average_price_per_merchant
    total = @merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end

    (total / @merchants.all.length.to_f).round(2)
  end

  def average_price_standard_deviation
    mean = average_average_price_per_merchant
    item_count = (@items.all.length.to_f - 1)

    sum = @items.all.sum do |item|
      (item.unit_price.to_f - mean)**2
    end

    Math.sqrt(sum / item_count).round(2)
  end

  def golden_items
    mean = average_average_price_per_merchant
    std_dev = average_price_standard_deviation
    threshold = mean + std_dev * 2

    @items.all.find_all do |item|
      item.unit_price > threshold
    end
  end

  def average_invoices_per_merchant
    (@invoices.all.length.to_f / @merchants.all.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean = average_invoices_per_merchant
    sum = @merchants.all.sum do |merchant|
      (@invoices.find_all_by_merchant_id(merchant.id).length.to_f - mean)**2
    end
    Math.sqrt(sum / (@merchants.all.length.to_f - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      (mean + 2 * std_dev) <= @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def bottom_merchants_by_invoice_count
    mean    = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation

    @merchants.all.find_all do |merchant|
      (mean - 2 * std_dev) >= @invoices.find_all_by_merchant_id(merchant.id).length
    end
  end

  def invoices_by_day
    invoices_by_day = { 0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0 }
    @invoices.all.each do |invoice|
      time = invoice.created_at.wday
      invoices_by_day[time] += 1
    end
    invoices_by_day
  end

  def invoices_by_day_mean
    (invoices_by_day.values.sum.to_f / 7).round(2)
  end

  def invoices_by_day_standard_deviation
    sum = invoices_by_day.values.sum do |daily_value|
      (daily_value - invoices_by_day_mean)**2
    end

    Math.sqrt(sum / 6.0).round(2)
  end

  def top_days_by_invoice_count
    top_values = invoices_by_day.values.find_all do |value|
      invoices_by_day_mean + invoices_by_day_standard_deviation <= value
    end

    top_values.map do |value|
      Date::DAYNAMES[invoices_by_day.key(value)]
    end
  end

  def invoice_status(status)
    total = @invoices.all.length.to_f
    (100.0 * @invoices.find_all_by_status(status).length / total).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    all_transaction = @transactions.find_all_by_invoice_id(invoice_id)

    if @transactions.find_all_by_invoice_id(invoice_id) != nil
      all_transaction.any? do |transaction|
        transaction.result == :success
      end
    else
      false
    end
  end

  def invoice_total(invoice_id)
    all_invoice_items = @invoice_items.find_all_by_invoice_id(invoice_id)

    if invoice_paid_in_full?(invoice_id) == true
      all_invoice_items.sum do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end
    else
      return 0
    end
  end

  def find_all_invoice_items_by_date(date)
    invoice_array = @invoices.all.find_all do |invoice|
      invoice.created_at == date
    end # => array of invoices created on date

    invoice_id_array = invoice_array.map do |invoice|
      invoice.id
    end # => array of invoice ids created on date

    invoice_id_array.map do |invoice_id|
      @invoice_items.find_all_by_invoice_id(invoice_id)
    end.flatten # => array of invoice items from date of invoice
  end

  def total_revenue_by_date(date)
    find_all_invoice_items_by_date(date).sum do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end

  def find_all_invoice_items_by_merchant(merchant)
    invoice_array = @invoices.all.find_all do |invoice|
      invoice.merchant_id == merchant.id
    end # => array of invoices for a given merchant

    invoice_id_array = invoice_array.map do |invoice|
      invoice.id
    end # => array of invoice ids for a given merchant

    invoice_id_array.map do |invoice_id|
      @invoice_items.find_all_by_invoice_id(invoice_id)
    end.flatten # => array of invoice items from a given merchant
  end

  def revenue_by_merchant(merchant)
    find_all_invoice_items_by_merchant(merchant).sum do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end # => 1 merchant's total revenue

  def top_revenue_earners(x = 20)
    # if we can't figure this out...
    # define a @total_revenue variable in the Merchant class
    # sort @merchants.all by total revenue
    # output top x
    arr = []
    @merchants.all.each do |merchant|
      arr << [merchant, revenue_by_merchant(merchant)]
    end
    arr
  end

  # def merchants_with_pending_invoices
  #     pending_array = @invoices.find_all_by_status(:pending)
  #     id_array = pending_array.map do |invoice|
  #       invoice.merchant_id
  #     end
  #     id_array.map do |id|
  #       @merchants.find_by_id(id)
  #     end.uniq!
  #   end

  def merchants_with_pending_invoices
    @invoices.all.map do |invoice|
      var = @transactions.find_all_by_invoice_id(invoice.id).none? do |transaction|
        transaction.result == :success
      end
      @merchants.find_by_id(invoice.merchant_id) if var
    end.uniq.compact
  end

  def merchants_with_only_one_item
    @merchants.all.find_all do |merchant|
      @items.find_all_by_merchant_id(merchant.id).length == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    months = {
      'January' => 1,
      'Febrary' => 2,
      'March' => 3,
      'April' => 4,
      'May' => 5,
      'June' => 6,
      'July' => 7,
      'August' => 8,
      'September' => 9,
      'October' => 10,
      'November' => 11,
      'December' => 12
    }

    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at[5..6].to_i == months[month]
    end
  end
end
