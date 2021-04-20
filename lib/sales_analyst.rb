require_relative './sales_engine'
require_relative './items'
require_relative './merchants'
require_relative './items_repo'
require_relative './merchants_repo'
require_relative './invoices'
require_relative './invoices_repo'
require_relative './mathable'
require 'bigdecimal'
require 'csv'

class SalesAnalyst
  include Mathable
  attr_reader :items_repo,
              :merchants_repo,
              :invoices_repo,
              :invoice_items_repo,
              :transactions_repo,
              :customers_repo

  def initialize(items_repo, merchants_repo, invoices_repo, invoice_items_repo, transactions_repo, customers_repo)
    @items_repo     = items_repo
    @merchants_repo = merchants_repo
    @invoices_repo  = invoices_repo
    @invoice_items_repo = invoice_items_repo
    @transactions_repo = transactions_repo
    @customers_repo = customers_repo
  end

  def all_items
    @all_items ||= @items_repo.all
  end

  def all_merchants
    @all_merchants ||= @merchants_repo.all
  end

  def all_invoices
    @all_invoices ||= @invoices_repo.all
  end

  def all_invoice_items
    @all_invoice_items ||= @invoice_items_repo.all
  end

  def all_transactions
    @all_transactions ||= @transactions_repo.all
  end

  def all_customers
    @all_customers ||= @customers_repo.all
  end

  def item_prices
   all_items.sum do |item|
      item.unit_price
    end
  end

  def item_prices_array
   all_items.map do |item|
      item.unit_price
    end
  end

  def average_items_per_merchant
    average(all_items.count.to_f, all_merchants.count.to_f).round(2)
  end

  def merchant_id_array
    all_merchants.map do |merchant|
      merchant.id
    end
  end

  def items_per_merchant
    merchant_id_array.map do |id|
      @items_repo.find_all_by_merchant_id(id).length
    end
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(items_per_merchant, average_items_per_merchant)
  end

  def average_unit_price
    average(item_prices.to_f, all_items.length.to_f)
  end

  def average_unit_price_standard_deviation
    standard_deviation(item_prices_array, average_unit_price)
  end

  def merchants_num_items_hash
    merchant_id_hash_keys = []
    all_merchants.each do |merchant|
      merchant_id_hash_keys << merchant.id
    end
    merchants_num_items_hash = Hash[merchant_id_hash_keys.zip(items_per_merchant)]
  end

  def merchants_with_high_item_count
    merchant_ids_with_high_item_count = []
    merchants_num_items_hash.each do |merchant_id, num|
      if z_score(num, average_items_per_merchant, average_items_per_merchant_standard_deviation) >= 1.0
        merchant_ids_with_high_item_count << merchant_id
      end
    end
    merchant_ids_with_high_item_count.map do |merchant_id|
      @merchants_repo.find_by_id(merchant_id)
      #where you are iterating more than once in one method
      # split off into other method?
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items_for_current_merchant = @items_repo.find_all_by_merchant_id(merchant_id)
    total_unit_price = items_for_current_merchant.sum do |item|
      item.unit_price
    end
    average(total_unit_price, items_for_current_merchant.length).round(2)
  end

  def average_average_price_per_merchant
    array_of_average_item_prices = all_merchants.map do |merchant|
      merchant_id = merchant.id
      average_item_price_for_merchant(merchant_id)
    end
   BigDecimal(average(array_of_average_item_prices.sum, array_of_average_item_prices.length)).round(2)
  end

  def golden_items
    sorted_items = all_items.sort_by do |item|
      item.unit_price
    end.reverse!
    top_items_by_price = sorted_items.take(10)
    top_items_by_price.find_all do |item|
      z_score(item.unit_price, average_average_price_per_merchant, average_unit_price_standard_deviation) >= 2.0
    end
  end

  def average_invoices_per_merchant
    average(all_invoices.count, all_merchants.count.to_f).round(2)
  end

  def invoices_per_merchant
    merchant_id_array.map do |id|
      @invoices_repo.find_all_by_merchant_id(id).length
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_per_merchant, average_invoices_per_merchant)
  end

  def merchants_num_invoices_hash
    merchant_id_hash_keys = []
    all_merchants.each do |merchant|
      merchant_id_hash_keys << merchant.id
    end
    merchants_num_invoices_hash = Hash[merchant_id_hash_keys.zip(invoices_per_merchant)]
  end
  #know which keys we have grab those ten keys and make a new hash that we test

  def top_merchants_by_invoice_count
    merchant_ids_with_high_invoice_count = []
    merchants_num_invoices_hash.each do |merchant_id, num|
      if z_score(num, average_invoices_per_merchant, average_invoices_per_merchant_standard_deviation) >= 2.0
        merchant_ids_with_high_invoice_count << merchant_id
      end
    end
    merchant_ids_with_high_invoice_count.map do |merchant_id|
      @merchants_repo.find_by_id(merchant_id)
    end
  end
  #stub helpers allow them to recive helper and tell it

  def bottom_merchants_by_invoice_count
    merchant_ids_with_low_invoice_count = []
    merchants_num_invoices_hash.each do |merchant_id, num|
      if z_score(num, average_invoices_per_merchant, average_invoices_per_merchant_standard_deviation) <= -2.0
        merchant_ids_with_low_invoice_count << merchant_id
      end
    end
    merchant_ids_with_low_invoice_count.map do |merchant_id|
      @merchants_repo.find_by_id(merchant_id)
    end
  end

  def invoices_per_day
    days_of_week = [0, 1, 2, 3, 4, 5, 6]
    days_of_week.map do |day|
      all_invoices.count do |invoice|
        invoice.created_at.wday == day
      end
    end
  end

  def average_invoices_per_day
    average(invoices_per_day.sum, days.length)
  end

  def days
    days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  end

  def days_invoices_hash
    days_invoices_hash = days.zip(invoices_per_day)
  end

  def days_by_invoice_standard_deviation
    standard_deviation(invoices_per_day, average_invoices_per_day)
  end

  def top_days_by_invoice_count
    top_days = []
    days_invoices_hash.each do |day, num_of_invoices|
      if z_score(num_of_invoices, average_invoices_per_day, days_by_invoice_standard_deviation) > 1
        top_days << day
      end
    end
    top_days
  end

  def invoice_status(status)
    num_of_matching_invoices = all_invoices.find_all do |invoice|
      invoice.status == status
    end.length
    rough = ((num_of_matching_invoices.to_f / all_invoices.length.to_f) * 100)
    result = rough.round(2)
  end

  def find_transaction(id)
    all_transactions.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def transactions_exist?(invoice_id)
    @transactions = find_transaction(invoice_id)
    @transactions != []
  end

  def failed_transactions
    @transactions.map do |transaction|
      if transaction.result == :failed
        false
      else
        true
      end
    end
  end

  def invoice_paid_in_full?(invoice_id)
    if transactions_exist?(invoice_id)
      failed_transactions.uniq.first
    else
      false
    end
  end

  def find_invoice_items(id)
    all_invoice_items.find_all do |invoice|
        invoice.invoice_id == id
    end
  end

  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id)
      total = find_invoice_items(invoice_id).map do |invoice|
        invoice.unit_price * invoice.quantity
      end.sum
    end
  end
end
