require_relative 'require_store'

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :customers,
              :transactions
  def initialize(items, merchants, invoices, invoice_items, customers, transactions)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @customers = customers
    @transactions = transactions
  end

  def average_items_per_merchant
    (items.all.length.to_f / merchants.all.length).round(2)
  end

  def merch_hash
    hsh = items.all.group_by do |item|
      item.merchant_id
    end
    hsh.map do |keys, values|
      hsh[keys] = values.count
    end
    hsh
  end

  def average_items_per_merchant_standard_deviation
    sqr_diff = merch_hash.sum do |merchant, items|
      (items - average_items_per_merchant)**2.0
    end
    Math.sqrt(sqr_diff / (merch_hash.keys.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    merch_hash.filter_map do |merchant, items|
     next if items - average_items_per_merchant_standard_deviation < average_items_per_merchant
     merchants.find_by_id(merchant)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_specific_items = items.find_all_by_merchant_id(merchant_id)
    merchant_total_value = merchant_specific_items.sum do |item|
      item.unit_price
    end
    (merchant_total_value / merchant_specific_items.length).round(2)
  end

  def average_invoices_per_merchant
    (invoices.all.length.to_f / merchants.all.length).round(2)
  end

  def inv_hash
    inv_hsh = invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
    inv_hsh.map do |keys, values|
      inv_hsh[keys] = values.count
    end
    inv_hsh
  end

  def average_invoices_per_merchant_standard_deviation
    sqr_diff = inv_hash.sum do |merchant, number|
      (number - average_invoices_per_merchant)**2.0
    end
    Math.sqrt((sqr_diff / (inv_hash.keys.count - 1))).round(2)
  end

  def avg_price_per_item
    items.all.sum { |item| item.unit_price} / items.all.length
  end

  def average_item_price_standard_deviation
    sqr_diff = items.all.sum do |item|
      (item.unit_price - avg_price_per_item)**2.0
    end
    Math.sqrt(sqr_diff / (items.all.count - 1)).round(2)
  end

  def golden_items
    min = avg_price_per_item + (average_item_price_standard_deviation * 2)
    max = 99999
    items.find_all_by_price_in_range(min..max)
  end

  def average_average_price_per_merchant
    total_average_price = merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (total_average_price / merchants.all.length).round(2)
  end

  def invoice_status(status)
    total_by_status = invoices.find_all_by_status(status)
    ((total_by_status.length.to_f / invoices.all.length) * 100).round(2)
  end

  def average_invoices_per_day
    invoices.all.length.to_f / 7
  end

  def day_hash
    day_hsh = invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%A")
    end
    day_hsh.map do |keys, values|
      day_hsh[keys] = values.count
    end
    day_hsh
  end

  def average_invoices_per_day_standard_deviation
    sqr_diff = day_hash.sum do |day, number|
      (number - average_invoices_per_day)**2.0
    end
    Math.sqrt((sqr_diff / 6)).round(2)
  end

  def top_merchants_by_invoice_count
    inv_hash.filter_map do |merchant, amount|
      next if ((average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant) > amount
      @merchants.find_by_id(merchant)
    end
  end

  def bottom_merchants_by_invoice_count
    inv_hash.filter_map do |merchant, amount|
      next if (average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2) < amount
      @merchants.find_by_id(merchant)
    end
  end

  def top_days_by_invoice_count
    day_hash.filter_map do |day, amount|
      day if amount > (average_invoices_per_day + average_invoices_per_day_standard_deviation)
    end
  end

  def invoice_paid_in_full?(invoice)
    transactions_in_invoice = transactions.find_all_by_invoice_id(invoice)
    transactions_in_invoice.any? { |transaction| transaction.result == :success}
  end

  def invoice_total(invoice)
    if !invoice_paid_in_full?(invoice)
      return 0
    else
      invoice_items_specific = invoice_items.find_all_by_invoice_id(invoice)
      invoice_items_specific.sum { |ii| ii.unit_price * ii.quantity}.round(2)
    end
  end

  def top_revenue_earners(top_earners = 20)
    sorted_merchants = merchants.all.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end
    sorted_merchants.reverse.first(top_earners)
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoices.sum do |invoice|
      invoice_total(invoice.id)
    end
  end

  def merchants_with_only_one_item
    merchants.all.find_all do |merchant|
      items.find_all_by_merchant_id(merchant.id).length <= 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_by_month_created = merchants_with_only_one_item.group_by do |merchant|
      merchant.created_at.strftime("%B").downcase
    end
    merchants_by_month_created[month.downcase]
  end
end

