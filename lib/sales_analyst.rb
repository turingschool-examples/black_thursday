require 'csv'
require 'pry'
require 'bigdecimal'
require 'time'
require 'date'
require_relative './sales_engine'
require_relative './standard_deviation'

class SalesAnalyst
  extend StandardDeviation

  attr_reader :engine
  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    (engine.items.all.count.to_f / engine.merchants.all.count).round(2)
  end

  def reduce_shop_items
    engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.id] = []
      engine.items.all.each do |item|
        if item.merchant_id == merchant.id
          memo[merchant.id] << item.unit_price
        end
      end
      memo
    end
  end

  def number_of_items
    reduce_shop_items.map{|merchant, item| item.count }
  end

  def average_items_per_merchant_standard_deviation
    numbers = number_of_items.extend(StandardDeviation)
    numbers.standard_deviation
  end

  def average_by_average_merchant_deviation
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchant_names_with_high_item_count
    deviation = average_by_average_merchant_deviation
    array = reduce_shop_items.map do |shop, item|
      if item.count >= deviation
        shop
      end
    end
    array.uniq[1..-1]
  end

  def merchants_with_high_item_count
    merchant_array = []
    merchant_names_with_high_item_count.each do |merchant_name|
      engine.merchants.all.each do |merchant_object|
        merchant_array << merchant_object if merchant_object.id == merchant_name
      end
    end
    merchant_array
  end

  def average_item_price_for_merchant(merchant_id)
    item_shop = reduce_shop_items.extend(StandardDeviation)
    (item_shop[merchant_id].sum / item_shop[merchant_id].count).round(2)
  end

  def average_average_price_per_merchant
    average_price = reduce_shop_items
    prices = engine.merchants.all.map do |merchant|
      (average_price[merchant.id].sum / average_price[merchant.id].count)
    end
    BigDecimal(prices.sum / average_price.keys.count).round(2)
  end

  def second_deviation_above_unit_price
    unit_price_array = reduce_shop_items.values.flatten
    unit_price_array = unit_price_array.extend(StandardDeviation)
    (average_average_price_per_merchant) + (unit_price_array.standard_deviation * 2)
  end

  def golden_items
    golden = []
    deviation = second_deviation_above_unit_price
    engine.items.all.each do |item|
      golden << item if item.unit_price > deviation
    end
    golden
  end

  def average_invoices_per_merchant
    (engine.invoices.all.count / engine.merchants.all.count.to_f).round(2)
  end

  def reduce_merchants_and_invoices
  end_hash = engine.merchants.all.reduce({}) do |memo, merchant|
      memo[merchant.id] = []
      engine.invoices.all.map do |invoice|
        if invoice.merchant_id == merchant.id
          memo[merchant.id] << invoice
        end
      end
      memo
    end
  end

  def number_of_invoices
    result = reduce_merchants_and_invoices.map{|merchant, invoice| invoice.count }
  end

  def average_invoices_per_merchant_standard_deviation
    result = number_of_invoices.extend(StandardDeviation)
    result.standard_deviation
  end

  def second_deviation_above_average_invoice_count
    invoices_per_merchant = number_of_invoices
    invoices_per_merchant = invoices_per_merchant.extend(StandardDeviation)
    ((average_invoices_per_merchant) + (invoices_per_merchant.standard_deviation * 2)).round(2)
  end

  def top_merchants_by_invoice_count
    top_merchants = []
    deviation = second_deviation_above_average_invoice_count
    merchant_hash = reduce_merchants_and_invoices
    merchant_hash.map do |merchant, array|
      if array.count > deviation
        top_merchants << engine.merchants.find_by_id(merchant)
      end
    end
    top_merchants
  end

  def second_deviation_below_average_invoice_count
    invoices_per_merchant = number_of_invoices
    invoices_per_merchant = invoices_per_merchant.extend(StandardDeviation)
    ((average_invoices_per_merchant) - (invoices_per_merchant.standard_deviation * 2)).round(2)
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants = []
    deviation = second_deviation_below_average_invoice_count
    merchant_hash = reduce_merchants_and_invoices
    merchant_hash.map do |merchant, array|
      if array.count < deviation
        bottom_merchants << engine.merchants.find_by_id(merchant)
      end
    end
    bottom_merchants
  end

  def reduce_invoices_and_days
   final_hash = engine.invoices.all.group_by{|invoice| invoice.created_at.strftime("%A")}
  end

  def invoices_by_day_count
    reduce_invoices_and_days.map{|invoice, day| day.count}
  end

  def average_invoices_per_day_standard_deviation
    result = invoices_by_day_count.extend(StandardDeviation)
    result.standard_deviation
  end

  def average_invoices_per_day
    result = invoices_by_day_count.extend(StandardDeviation)
    result.item_mean.round(2)
  end

  def one_deviation_above_invoices_per_day
    work  = invoices_by_day_count.extend(StandardDeviation)
    work.standard_deviation + average_invoices_per_day
  end

  def top_days_by_invoice_count
    result = []
    deviation = one_deviation_above_invoices_per_day
    reduce_invoices_and_days.map do |day, invoices|
      if invoices.count > deviation
       result << invoices[0].created_at.strftime("%A")
      end
    end
    result
  end

  def invoice_status(status)
    total_status = engine.invoices.all.find_all{|invoice| invoice.status == status}.count
    ((total_status.to_f / engine.invoices.all.count) * 100).round(2)
  end

  def find_all_pending_invoices
    pending_invoices = @engine.invoices.all.find_all do |invoice|
      !invoice_paid_in_full?(invoice.id)
    end
  end

  def merchants_with_pending_invoices
    updated = find_all_pending_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
    final_array = updated.map do |id|
      @engine.merchants.find_by_id(id)
    end.uniq
    final_array
  end

  def merchants_with_only_one_item
    grouped_items = @engine.items.all.group_by { |item| item.merchant_id }
    merchant_array =  grouped_items.select do |key, value|
      value.count == 1
    end
    merchant_ids = merchant_array.keys
    final_array = merchant_ids.map do |id|
      @engine.merchants.find_by_id(id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    int_month = Date::MONTHNAMES.index(month)

    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.month == int_month
    end
  end

  def transaction_to_invoice(transaction)
    invoice_id = transaction.invoice_id
    invoice = @engine.invoices.find_by_id(invoice_id)
  end

  def transaction_dollar_value(transaction)
    invoice = transaction_to_invoice(transaction).id
    all_items = @engine.invoice_items.find_all_by_invoice_id(invoice)
    all_items.sum { |item| item.unit_price }
  end

  def validate_merchants(merchant_id)
   merchant_invoices = engine.invoices.all.find_all do |invoice|
     invoice.merchant_id == merchant_id
   end
   merchant_invoices.find_all do |invoice|
     invoice_paid_in_full?(invoice.id)
   end
 end

  def revenue_by_merchant(merchant_id)
    validated_merchant_invoices = validate_merchants(merchant_id)
    array = []
    validated_merchant_invoices.each do |invoice|
      array << invoice_total(invoice.id)
    end

    array.sum
    # success_array = @engine.transactions.all.find_all do |transaction|
    #   invoiced_merchant_id = transaction_to_invoice(transaction).merchant_id
    #   transaction.result == :success && invoiced_merchant_id == merchant_id
    # end
    # result = transaction_dollar_value(success_array[0])
    # success_array.sum { |transaction| transaction_dollar_value(transaction) }
  end

  def invoice_paid_in_full?(invoice_id)
    all_transactions = engine.transactions.all

    transactions = all_transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
    if transactions == []
      return false
    else
      transactions.any? { |transaction| transaction.result == :success}
    end
  end

  def invoice_total(invoice_id)
    all_invoice_items = engine.invoice_items.all

    invoices_items = all_invoice_items.find_all do |item|
      item.invoice_id == invoice_id
    end

    items_total = invoices_items.map do |item|
      item.quantity * item.unit_price
    end

    BigDecimal(items_total.sum).round(2)
  end

  def total_revenue_by_date(date)
    invoices_by_date = engine.invoices.all.find_all do |invoice|
      invoice.created_at.strftime("%d/%m/%Y") == date.strftime("%d/%m/%Y")
    end
    revenue = invoices_by_date.map do  |invoice|
      invoice_total(invoice.id) if invoice_paid_in_full?(invoice.id)
    end
    revenue.compact.sum
  end

  def merchants_top_revenue_earners
    engine.merchants.all.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse
  end

  def top_revenue_earners(x = 20)
    merchants_top_revenue_earners[0..x-1]
  end

  def best_item_for_merchant(merchant_id)
    invoices_array = engine.invoices.find_all_by_merchant_id(merchant_id)
    invoices_paid = invoices_array.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end
    final_hash = {} #Hash.new {|h,k| h[k]=[]}
    invoices_paid.each do |invoice|
      engine.invoice_items.find_all_by_invoice_id(invoice.id).each do |invoice_item|
       if final_hash[invoice_item.item_id].nil?
        final_hash[invoice_item.item_id] = engine.invoice_items.find_all_by_item_id(invoice_item.item_id)
       else 
        final_hash[invoice_item.item_id] << engine.invoice_items.find_all_by_item_id(invoice_item.item_id)
       end
      end
    end
    actual_final_hash = {}

    final_hash.each do |id, items_array|
      sum = 0
      items_array.each do |inv_item|
        if inv_item.class != InvoiceItem
        else
        sum += (inv_item.unit_price * inv_item.quantity)
        end
        actual_final_hash[id] = sum
      end
      
    end

    result = actual_final_hash.max_by{|k,v| v}
    item_id = result[0]
    answer_holy_shit = engine.items.find_by_id(item_id)
  end


end
