require_relative 'require_store'

module Calculation
  def standard_deviation_by_merchant(hash_type)
    hash = grouped_by_merchant_id(hash_type)
    sqr_diff = hash.sum do |key, value|
      (value - average_by_merchant(hash_type))**2.0
    end
    Math.sqrt(sqr_diff / (hash.keys.count - 1)).round(2)
  end

  def average_by_merchant(averagee)
    (averagee.all.length / merchants.all.length.to_f).round(2)
  end

  def grouped_by_merchant_id(value)
    hash = value.all.group_by(&:merchant_id)
    hash.map do |keys, values|
      hash[keys] = values.count
    end
    hash
  end

  def avg_price_per_item
    items.all.sum(&:unit_price) / items.all.length
  end

  def average_item_price_standard_deviation
    sqr_diff = items.all.sum do |item|
      (item.unit_price - avg_price_per_item)**2.0
    end
    Math.sqrt(sqr_diff / (items.all.count - 1)).round(2)
  end

  def average_average_price_per_merchant
    total_average_price = merchants.all.sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (total_average_price / merchants.all.length).round(2)
  end

  def day_hash
    day_hsh = invoices.all.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
    day_hsh.map do |keys, values|
      day_hsh[keys] = values.count
    end
    day_hsh
  end

  def merchants_by_invoice_count(comparison)
    bottom = (average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation * 2)
    top = ((average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant)
    grouped_by_merchant_id(invoices).filter_map do |merchant, amount|
      next if top > amount && comparison == 'top'
      next if bottom < amount && comparison == 'bottom'

      @merchants.find_by_id(merchant)
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoices = invoices.find_all_by_merchant_id(merchant_id)
    merchant_invoices.sum do |invoice|
      invoice_total(invoice.id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant_total_value = items_merchant_specific(merchant_id).sum(&:unit_price)
    (merchant_total_value / items_merchant_specific(merchant_id).length).round(2)
  end

  def average_invoices_per_merchant
    average_by_merchant(invoices)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation_by_merchant(invoices)
  end

  def average_invoices_per_day
    invoices.all.length.to_f / 7
  end

  def average_invoices_per_day_standard_deviation
    sqr_diff = day_hash.sum do |_day, number|
      (number - average_invoices_per_day)**2.0
    end
    Math.sqrt((sqr_diff / 6)).round(2)
  end

  def average_items_per_merchant
    average_by_merchant(items)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation_by_merchant(items)
  end

  def spending_by_customer(customer_id)
    customer_invoices = invoices.find_all_by_customer_id(customer_id)
    customer_invoices.sum do |invoice|
      invoice_total(invoice.id)
    end
  end
end