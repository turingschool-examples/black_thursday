# frozen_string_literal: true
require 'BigDecimal'
require 'Date'
#require_relative 'invoice'
#require_relative 'invoice_repository'

# SalesAnalyst class creates handles all analysis of merch, items, and invoices

class SalesAnalyst
  attr_reader :items,
              :merchants,
              :merch_item_hash,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(items, merchants, invoices, transactions, invoice_items, customers)
    @items = items.all
    @merchants = merchants.all
    @invoices = invoices.all
    @transactions = transactions.all
    @invoice_items = invoice_items.all
    @customers = customers.all
    @merch_item_hash = hash_create
  end

  def hash_create
    return_hash = {}
    merchants.each do |merchant|
      items.each do |item|
        if merchant.id == item.merchant_id
          if return_hash[merchant].nil?
            return_hash[merchant] = [item]
          else
            return_hash[merchant] += [item]
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
      if items.length > (average_items_per_merchant_standard_deviation + average_items_per_merchant)
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
        num_items += 1
      end
    end
    BigDecimal(sum_amount.to_f / num_items.to_f, 4)
  end

  def average_average_price_per_merchant
    sum_price = 0
    avg_price_array.each { |avg_price| sum_price += avg_price }
    BigDecimal(sum_price.to_f / @merchants.length.to_f, 5)
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
    result_array
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
    two_sd = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    merchant_invoice_count.each do |merchant, invoices|
      if invoices > two_sd
        result_array.append(merchant)
      end
    end
    result_array
  end

  def bottom_merchants_by_invoice_count
    result_array = []
    negative_two_sd = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    merchant_invoice_count.each do |merchant, invoices|
      if invoices < negative_two_sd
        result_array.append(merchant)
      end
    end
    result_array
  end

  def top_days_by_invoice_count
    standard_deviation = days_of_week_hash.sum do |key, value|
      (value - average_invoices_per_day)**2
    end
    standard_deviation = (standard_deviation / 6)**0.5

    day_array = days_of_week_hash.map do |key, value|
      key if value >= (average_invoices_per_day + standard_deviation)
    end.compact
  end

  def average_invoices_per_day
    average = days_of_week_hash.sum do |key, value|
      value
    end
    average = average / 7
  end

  def days_of_week_hash
    days_of_week_hash = {}
    invoices.each do |invoice|
      days_of_week_hash[invoice.created_at.strftime("%A")] ||= 0
      days_of_week_hash[invoice.created_at.strftime("%A")] += 1
    end
    days_of_week_hash
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
      transaction.invoice_id == invoice_id && transaction.result == :success
    end
    paid_in_full_status.length >= 1
  end

  def invoice_total(invoice_id)
    total_of_invoice = 0
    matching_transactions(invoice_id).each do |transaction|
      matching_invoices(transaction.invoice_id).each do |invoice|
        total_of_invoice += invoice.quantity * invoice.unit_price
      end
    end
    (total_of_invoice / 100).round(2)
  end

  def total(invoice_id)
    invoice_total(invoice_id)
  end

  def matching_transactions(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id && transaction.result == 'success'
    end
  end

  def matching_invoices(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def total_revenue_by_date(date)
    

  def merchants_with_pending_invoices
    merchant_array = []
    ids = []
    invoices.each do |invoice|
      ids.push(invoice.merchant_id) if invoice.status != :success
    end
    ids.each do |id|
      merchants.each do |merchant|
        merchant_array.push(merchant) if merchant.id == id
      end
    end
    merchant_array.uniq
  end

  def revenue_by_merchant(merchant_id)
    total_rev = 0
    invoices.each do |invoice|
      if invoice.merchant_id == merchant_id
        transactions.each do |transaction|
          if transaction.result == 'success'
            invoice_items.each do |item|
              if item.invoice_id == transaction.invoice_id
                total_rev += (item.quantity * item.unit_price)
              end
            end
          end
        end
      end
    end
    BigDecimal(total_rev.to_f / 100.0, 2)
  end

  def merchants_with_only_one_item
    one_item = []
    items_by_merchant.map do |merchant, items|
      if items.length == 1
         one_item << merchant
      end
    end
    one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.map do |merchant|
      merchant if merchant.created_at.strftime('%B') == month
    end.compact
  end




  def top_revenue_earners(number_of_merchants = 20)
    total_revenue_generation

    merch_by_revenue = merchants.sort_by(&:total_revenue)
    merch_by_revenue.compact.reverse[0..(number_of_merchants - 1)]
  end

  # assigns the total revenue earned for each merchant to them
  def total_revenue_generation
    items_by_merchant.each do |merchant, items|
      total_revenue = 0
      items.each do |item|
        invoice_items.each do |invoice_item|
          if invoice_item.item_id === item.id
            total_revenue += invoice_item.quantity * invoice_item.unit_price
          end
        end
      end
      merchant.total_revenue = total_revenue
    end
  end

  # def transaction_is_success?(invoice_item)
  #   v = transactions.find_all do |transaction|
  #     transaction.invoice_id == invoice_item.invoice_id
  #   end
  #   v2 = v.find do |transaction|
  #     transaction.result == :failed
  #   end
  #   !v2.include?(Transaction)
  # end

  # helper method for merchant related methods
  def items_by_merchant
    items_by_merchant = {}
    merchants.each do |merchant|
      items_by_merchant[merchant] = items.map do |item|
        item if item.merchant_id == merchant.id
      end.compact
    end
    items_by_merchant
  end
end
