# frozen_string_literal: true

require_relative 'merchant'
require_relative 'general_repo'

# This is the MerchantRepository Class
class MerchantRepository < GeneralRepo
  attr_reader :repository

  def initialize(data, engine)
    super(Merchant, data, engine)
  end

  def find_by_name(name)
    repository.find { |merchant| merchant.name.casecmp?(name) }
  end

  def find_all_by_name(name)
    repository.select { |merchant| merchant.name.downcase.include? name.downcase }
  end

  def number_of_items_per_merchant
    all.map do |merchant|
      merchant.item_count
    end
  end

  def items_per_merchant
    all.map do |merchant|
      merchant._items
    end
  end

  def average_items_per_merchant
    average(number_of_items_per_merchant.sum, all.length).round(2)
  end

  def average_items_per_merchant_standard_deviation
    deviation(number_of_items_per_merchant, average_items_per_merchant).round(2)
  end

  def number_of_invoices_per_merchant
    all.map do |merchant|
      merchant.invoice_count
    end
  end

  def average_invoices_per_merchant
    average(number_of_invoices_per_merchant.sum, all.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    deviation(number_of_invoices_per_merchant, average_invoices_per_merchant).round(2)
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    mer_avg = average_invoices_per_merchant
    all.select do |merchant|
      deviation_difference(std_dev, merchant.invoice_count, mer_avg) > 2
    end
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    mer_avg = average_invoices_per_merchant
    all.select do |merchant|
      deviation_difference(std_dev, merchant.invoice_count, mer_avg) < -2
    end
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    avg_count = average_items_per_merchant
    all.select do |merchant|
      deviation_difference(std_dev, merchant.item_count, avg_count) > 1
    end
  end

  def average_item_price_for_merchant(id)
    find_by_id(id).avg_item_price
  end

  def average_average_price_per_merchant
    total_avg_item_prices = all.sum { |merchant| average_item_price_for_merchant(merchant.id) }
    average(total_avg_item_prices, all.length).round(2)
  end


  def merchants_with_only_one_item
    all.select { |merchant| merchant.item_count == 1 }
  end

  def merchants_with_only_one_item_registered_in_month(month_name)
    merchants_with_only_one_item.select do |merchant|
      merchant.created_at.month == month_to_int(month_name)
    end
  end

  def merchants_with_pending_invoices
    all.select { |merchant| merchant.invoice_pending? }
  end
  
  def top_revenue_earners(num)
    sorted = all.sort_by do |merchant|
      -merchant.revenue
    end
    sorted.first(num)
  end

  def revenue_by_merchant(id)
    find_by_id(id).revenue
  end
end
