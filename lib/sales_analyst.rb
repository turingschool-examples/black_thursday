# frozen_string_literal: true
require 'BigDecimal'
require './lib/invoice'
require './lib/invoice_repository'

# SalesAnalyst class creates handles all analysis of merch, items, and invoices

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :merch_item_hash,
              :invoices,
              :invoice_items,
              :transactions

  def initialize(items, merchants, invoices, transactions, invoice_items)
    @items = items.all
    @merchants = merchants.all
    @invoices = invoices.all
    @transactions = transactions.all
    @invoice_items = invoice_items.all
    @merch_item_hash = hash_create
  end

  def hash_create
    return_hash = {}
    merchants.each do |merchant|
      items.each do |item|
        if merchant.id == item.merchant_id
          if return_hash[merchant.name].nil?
            return_hash[merchant.name] = [item]
          else
            return_hash[merchant.name] += [item]
          end
        end
      end
    end
    return_hash
  end

  def average_items_per_merchant
    num_merchants = @merchants.length.to_f
    num_items = @items.length.to_f
    expected = (num_items / num_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    sum_diff_squared = 0
    @merch_item_hash.each do |merchant,items|
      sum_diff_squared += (items.length - average_items_per_merchant)**2
    end
    ((sum_diff_squared / @merchants.length.to_f)**0.5).round(2)
  end

  def merchants_with_high_item_count
    return_array = []
    @merch_item_hash.each do |merchant,items|
      if items.length >= (average_items_per_merchant_standard_deviation + average_items_per_merchant)
        return_array.push(merchant)
      end
    end
    return_array
  end

  def average_item_price_for_merchant(merchant_id)
    sum_amount = 0
    num_items = 0
    @items.each do |item|
      if item.merchant_id == merchant_id
        sum_amount += item.unit_price.to_f
        num_items += 1.to_f
      end
    end
    BigDecimal(sum_amount / num_items, 2)
  end

  def average_average_item_price_for_merchant
    sum_price = 0
    avg_price_array.each { |avg_price| sum_price += avg_price }
    BigDecimal(sum_price.to_f / @merchants.length.to_f, 2)
  end

  def avg_price_array
    return_array = []
    @merch_item_hash.each do |merchant, items|
      total_price = 0
      item_count = items.length.to_f
      items.each do |item|
        total_price += item.unit_price.to_f
      end
      return_array.push(total_price.to_f / item_count.to_f)
    end
    return_array
  end

  def average_price_all
    num_items = @items.length
    items_price = 0
    @items.each do |item|
      items_price += item.unit_price.to_f
    end
    (items_price / num_items.to_f).round(2)
  end

  def average_price_standard_deviation
    sum_diff_squared = 0
    avg = average_price_all
    @items.each do |item|
      sum_diff_squared += ((item.unit_price.to_f - avg)**2)
    end
    ((sum_diff_squared / items.length.to_f)**0.5).round(2)
  end

  def golden_items
    result_array = []
    expected = (average_price_all + (average_price_standard_deviation * 2))
    @items.each do |item|
      result_array.append(item) if item.unit_price.to_f >= expected
    end
  end

  def average_invoices_per_merchant
    (@invoices.length.to_f / @merchants.length.to_f).round(2)
  end

  def merchant_invoice_count
    merchant_invoice_hash = {}
    invoices.each do |invoice|
      merchants.each do |merchant|
        if invoice.merchant_id == merchant.id
          merchant_invoice_hash[merchant] ||= 0
          merchant_invoice_hash[merchant] += 1
        end
      end
    end
    merchant_invoice_hash
  end

  def average_invoices_per_merchant_standard_deviation
    sum_diff_squared = 0
    avg = average_invoices_per_merchant
    merchant_invoice_count.each do |key, value|
      sum_diff_squared += ((value - avg)**2)
    end
    ((sum_diff_squared / (merchants.length.to_f - 1))**0.5).round(2)
  end


  def top_merchants_by_invoice_count
    result_array = []
    two_sd = (average_invoices_per_merchant_standard_deviation) * 2
    @merchants.each do |merchant|
      if invoices.length > (two_sd)
        result_array.append(merchant)
      end
    end
  end

  def bottom_merchants_by_invoice_count
    result_array = []
    two_sd = average_invoices_per_merchant_standard_deviation * 2
    @merchants.each do |merchant|
      if (invoices.length + two_sd) < average_invoices_per_merchant
        result_array.append(merchant)
      end
    end
  end

  def top_days_by_invoice_count
    result_array = []
    invoice_created = @invoices.created_at
    average_created_at = average_invoices_per_merchant.created_at
    sd = average_invoices_per_merchant_standard_deviation
    @merchants.each do |merchant|
      if invoice_created.length > average_created_at.length + sd
        result_array.append(merchant)
      end
    end
  end

  def invoice_status_count(status)
    invoices.map do |invoice|
      invoice if invoice.status.to_sym == status
    end.compact
  end

  def invoice_status(status)
    ((invoice_status_count(status).length.to_f / invoices.length) * 100).to_f.round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    paid_in_full_status = transactions.select do |transaction|
      transaction.invoice_id == invoice_id && transaction.result == 'success'
    end
    paid_in_full_status.length >= 1
  end

  def invoice_total(invoice_id)
    total_of_invoice = 0
    matching_transactions(invoice_id).each do |transaction|
      matching_invoices(invoice_id).each do |invoice|
        total_of_invoice += invoice.quantity * invoice.unit_price
      end
    end
    (total_of_invoice / 100).round(2)
  end

  def matching_transactions(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id && transaction.result == "success"
    end
  end

  def matching_invoices(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end
end

# find transaction with invoice id and make sure it was a success
# find all invoice_items with corresponding invoice id
# add all total prices together (quantity * unit_price)
# convert to USD
