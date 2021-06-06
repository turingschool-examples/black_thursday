require 'date'
require_relative 'helper_methods'

class SalesAnalyst
  include HelperMethods
  attr_reader :items, :merchants, :invoices, :engine, :all

  def initialize(item_repo, merchant_repo, invoice_repo, engine)
    @items = item_repo
    @merchants = merchant_repo
    @invoices = invoice_repo
    @engine = engine
    @all = nil
  end

  def set_all(repo)
    @all = repo.all
  end

  def reset_all
    @all = nil
  end

  def group_items_by_merchant_id
    @items.all.group_by do |item|
      item.merchant_id
    end
  end

  def group_invoices_by_merchant_id
    @invoices.all.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def average_items_per_merchant
    grouping = group_items_by_merchant_id
    total = group_items_by_merchant_id.values.sum do |items_array|
      items_array.length
    end
    (total / grouping.values.length.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    grouping = group_items_by_merchant_id
    mean = average_items_per_merchant
    result = grouping.values.reduce(0) do |total, items|
      total + ((items.length - mean)**2)
    end
    (Math.sqrt(result/(grouping.values.length.to_f - 1))).round(2)
  end

  def merchants_with_high_item_count
    collection_arr = []
    group_items_by_merchant_id.each do |merchant_id, items|
      if items.length >= (average_items_per_merchant + average_items_per_merchant_standard_deviation)
        collection_arr << merchant_id
      end
    end
    set_all(@merchants)
    result = collection_arr.map { |merchant_id| find_by_id(merchant_id) }
    reset_all
    result
  end

  def average_item_price_for_merchant(merchant_id)
    total = group_items_by_merchant_id[merchant_id.to_s].sum { |item| item.unit_price }
    mean = (total / (group_items_by_merchant_id[merchant_id.to_s].length))
    BigDecimal(mean.to_f, 4)
  end

  def average_average_price_per_merchant
    total = 0
    group_items_by_merchant_id.each do |merchant_id, items|
      total += (average_item_price_for_merchant(merchant_id) / 100)
    end
    mean = (total / group_items_by_merchant_id.values.length)
    # BigDecimal(mean, 4)
  end

  def average_item_price_standard_deviation
    total = @items.all.sum { |item| item.unit_price }
    mean = total / @items.all.length
    result = @items.all.reduce(0) do |total, item|
      total + ((item.unit_price - mean)**2)
    end
    Math.sqrt(result/(@items.all.length - 1))
  end

  def golden_items
    total = @items.all.sum { |item| item.unit_price }
    mean = total / @items.all.length
    @items.all.select do |item|
      item.unit_price >= (mean + (average_item_price_standard_deviation * 2))
    end
  end

  def average_invoices_per_merchant
    grouping = group_invoices_by_merchant_id
    total = group_invoices_by_merchant_id.values.sum do |invoices_array|
      invoices_array.length
    end
    (total / grouping.values.length.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    grouping = group_invoices_by_merchant_id
    mean = average_invoices_per_merchant
    result = grouping.values.reduce(0) do |total, invoices|
      total + ((invoices.length - mean)**2)
    end
    (Math.sqrt(result/(grouping.values.length.to_f - 1))).round(2)
  end

  def top_merchants_by_invoice_count
    collection_arr = []
    group_invoices_by_merchant_id.each do |merchant_id, invoices|
      if invoices.length >= (average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2))
        collection_arr << merchant_id
      end
    end
    set_all(@merchants)
    result = collection_arr.map { |merchant_id| find_by_id(merchant_id) }
    reset_all
    result
  end

  def bottom_merchants_by_invoice_count
    collection_arr = []
    group_invoices_by_merchant_id.each do |merchant_id, invoices|
      if invoices.length <= (average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2))
        collection_arr << merchant_id
      end
    end
    set_all(@merchants)
    result = collection_arr.map { |merchant_id| find_by_id(merchant_id) }
    reset_all
    result
  end

  def top_days_by_invoice_count
    @invoices.all[0]
    grouping = @invoices.all.group_by do |invoice|
      Date.parse(invoice.created_at.to_s).strftime("%A")
    end
    require "pry"; binding.pry
    # mean from grouping
    # stdev from the mean
    # call .select on grouping to return more than 1 stdev
  end

  def invoice_status
    # do stuff
  end

end
