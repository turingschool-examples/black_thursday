require 'bigdecimal'
require_relative 'item_analyst'
require_relative 'invoice_analyst'

require_relative 'math_helper'

class SalesAnalyst
  include MathHelper
  def initialize(merchant_repository,
                 item_repository,
                 invoice_repository,
                 transaction_repository,
                 invoice_item_repository)
    @merchant_repository      = merchant_repository
    @item_repository          = item_repository
    @invoice_repository       = invoice_repository
    @transaction_repository   = transaction_repository
    @invoice_item_repository  = invoice_item_repository

    @item_ana     = ItemAnalyst.new(@item_repository)
    @invoice_ana  = InvoiceAnalyst.new(@invoice_repository)
  end

  def average_items_per_merchant
    @item_ana.average_items_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    @item_ana.average_items_per_merchant_standard_deviation
  end

  def golden_items
    @item_ana.golden_items
  end

  def top_merchants_by_invoice_count
    mean  = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation * 2
    merchant_invoices = @invoice_ana.group_invoices_by_merchant_id

    merchant_invoices = merchant_invoices.find_all do |merchant, invoices|
      invoices.size > (mean + stdev)
    end

    merchant_ids = merchant_invoices.map { |array| array[0] }
    merchant_ids.map { |id| @merchant_repository.find_by_id(id) }
  end

   def bottom_merchants_by_invoice_count
    mean  = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation * 2
    merchant_invoices = @invoice_ana.group_invoices_by_merchant_id

    merchant_invoices = merchant_invoices.find_all do |merchant, invoices|
      invoices.size < (mean - stdev)
    end

    merchant_ids = merchant_invoices.map { |array| array[0] }
    merchant_ids.map { |id| @merchant_repository.find_by_id(id) }
  end

  def merchants_with_high_item_count
    stdev   = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_items    = @item_repository.group_item_by_merchant_id

    top_merchants   = []
    merchant_items.each do |merchant_id, items_array|
      if items_array.count > (stdev + average)
        top_merchants << @merchant_repository.find_by_id(merchant_id)
      end
    end

    top_merchants
  end

  def average_item_price_for_merchant(id)
    @item_repository.average_item_price_for_merchant(id)
  end

  def average_average_price_per_merchant
    @item_repository.average_average_price_per_merchant
  end

  def invoice_paid_in_full?(invoice_id)
    invoices = @transaction_repository.find_all_by_invoice_id(invoice_id)
    return false if invoices.empty?
    invoices.any? { |invoice| invoice.result == :success }
  end

  def invoice_total(invoice_id)
    invoices = @invoice_item_repository.find_all_by_invoice_id(invoice_id)
    invoices.inject(0) do |sum, invoice|
      sum + invoice.unit_price * invoice.quantity.to_i
    end
  end

  def total_revenue_by_date(date)
    invoices =  get_invoices_for_date(date)
    invoice_ids = invoices.map(&:id)

    invoice_items = invoice_ids.map do |id|
      @invoice_item_repository.find_all_by_invoice_id(id)
    end.flatten

    revenue_array = invoice_items.map do |invoice|
      (invoice.quantity.to_f * invoice.unit_price)
    end

    revenue_array.inject(0, &:+)
  end

  def get_invoices_for_date(date)
     @invoice_repository.invoices.select do |invoice|
       invoice.created_string == date.strftime("%F")
    end
  end

  def revenue_by_merchant(merchant_id)
    invoices = @invoice_repository.all.select do |invoice|
      invoice.merchant_id == merchant_id
    end

    paid_invoices = invoices.select do |invoice|
      invoice_paid_in_full?(invoice.id)
    end

    invoice_items = paid_invoices.map do |invoice|
      @invoice_item_repository.find_all_by_invoice_id(invoice.id)
    end

    invoice_items.flatten!
    revenue = invoice_items.inject(0) do |sum, invoice|
      sum += (invoice.unit_price * invoice.quantity.to_i)
    end
  end

  def top_revenue_earners(top_n=20)
    merchant_ids = get_merchant_ids
    merchant_revenue = {}
    merchant_ids.each do |merchant_id|
      merchant_revenue[merchant_id] = revenue_by_merchant(merchant_id)
    end

    top_merchants = merchant_revenue.sort_by do |merchant_id, revenue|
      - revenue
    end

    if top_n != nil
      top_merchants = top_merchants[0...top_n]
    else
      top_merchants
    end

    top_merchants.map do |array|
      @merchant_repository.find_by_id(array[0])
    end
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(nil)
  end

  def merchants_with_pending_invoices
    pending_invoices = @invoice_repository.all.reject do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
    merchant_ids = pending_invoices.map {|invoice| invoice.merchant_id}
    merchant_ids.uniq!
    merchants = merchant_ids.map do |merchant_id|
      @merchant_repository.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item
    merchant_ids = @item_repository.all.group_by do |item|
      item.merchant_id
    end
    single_ids = merchant_ids.select do |key, value|
      value.length == 1
    end
    merchants = single_ids.keys.map do |id|
      @merchant_repository.find_by_id(id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants = merchants_with_only_one_item
    merchants.select do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def get_merchant_ids
    @merchant_repository.all.map(&:id)
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = @invoice_repository.find_all_by_merchant_id(merchant_id)
    invoices = invoices.map(&:id)
    invoices = invoices.select {|invoice| invoice_paid_in_full?(invoice)}
    items = invoices.map do |invoice|
      @invoice_item_repository.find_all_by_invoice_id(invoice)
    end
    flat = items.flatten
    grouped = flat.group_by {|item| item.item_id}
    hash = {}
    grouped.each do |key, value|
      hash[key] = value.inject(0) do |sum, val|
        sum += val.quantity.to_i
      end
    end
    sorted = hash.sort_by {|key, value| - value }
    max = sorted.first[1]
    chunky_winners = sorted.reject { |array| array[1] < max }
    flat_winners = chunky_winners.flatten
    flat_winners = flat_winners.uniq
    winners = flat_winners.map {|item| @item_repository.find_by_id(item)}
    winners.compact
  end

  def best_item_for_merchant(merchant_id)
    invoices = @invoice_repository.find_all_by_merchant_id(merchant_id)
    invoices = invoices.map(&:id)
    invoices = invoices.select {|invoice| invoice_paid_in_full?(invoice)}
    items = invoices.map do |invoice|
      @invoice_item_repository.find_all_by_invoice_id(invoice)
    end
    flat = items.flatten
    grouped = flat.group_by {|item| item.item_id}
    hash = {}
    grouped.each do |key, value|
      hash[key] = value.inject(0) do |sum, val|
        sum += (val.unit_price * val.quantity.to_i).round(2)
      end
    end
    sorted = hash.sort_by {|key, value| - value }
    max = sorted.first[1]
    chunky_winners = sorted.reject { |array| array[1] < max }
    flat_winners = chunky_winners.flatten
    flat_winners = flat_winners.uniq
    winners = flat_winners.map {|item| @item_repository.find_by_id(item)}
    winners.compact.first
  end

  def invoice_status(status)
    @invoice_ana.percent_by_invoice_status(status)
  end

  def average_invoices_per_merchant
    @invoice_ana.average_invoices_per_merchant
  end

  def average_invoices_per_merchant_standard_deviation
    @invoice_ana.average_invoices_per_merchant_standard_deviation
  end

  def average_invoices_per_day_standard_deviation
    @invoice_ana.average_invoices_per_day_standard_deviation
  end

  def count_per_day
    @invoice_ana.group_by_day.map { |day, invoices| invoices.count }
  end

  def invoice_per_day_standard_deviation
    average = @invoice_ana.average_invoices_per_day
    abs_differences = count_per_day.map do |count|
      ((count - average).abs) ** 2.0
    end
    total = abs_differences.inject(0, &:+)
    (Math.sqrt(total / 6)).round(2)
  end

  def top_days_by_invoice_count
    st_dev = @invoice_ana.average_invoices_per_day + invoice_per_day_standard_deviation
    day_counts = @invoice_ana.group_by_day
    day_counts.select { |_day, invoices | invoices.size > st_dev }.keys
  end
end
