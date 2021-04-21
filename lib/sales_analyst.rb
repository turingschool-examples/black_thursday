require_relative 'sales_engine'
require 'bigdecimal'

class SalesAnalyst
  attr_reader :engine

  def initialize(engine)
    @engine = engine
    @merchant_id_array = @engine.all_merchant_ids
  end

  def average_items_per_merchant
    @engine.number_of_class(:items).fdiv(@engine.number_of_class(:merchants)).round(2)
  end

  def standard_deviation(array, average)
    sum_of_squares = array.sum do |object|
      (object - average)**2
    end
    (sum_of_squares.fdiv(array.length - 1)**0.5).round(2)
  end

  # Brant's magic method
  def average_items_per_merchant_standard_deviation
    items_average = average_items_per_merchant
    items_per_merchant = @merchant_id_array.map do |id|
      @engine.items.find_all_by_merchant_id(id).length
    end
    standard_deviation(items_per_merchant, items_average)
  end

  def merchants_with_high_item_count
    one_standard = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchant_ids_high_count = @merchant_id_array.find_all do |id|
      number_of_merchant_items = @engine.items.find_all_by_merchant_id(id).length
      number_of_merchant_items > one_standard
    end
    @engine.csv_array(:merchants).find_all do |merchant|
      merchant_ids_high_count.include?(merchant.id)
    end
  end

  def average_item_price_for_merchant(id)
    items_by_merchant_array = @engine.items.find_all_by_merchant_id(id)
    test = items_by_merchant_array.sum do |item|
      item.unit_price
    end / items_by_merchant_array.length
    test.round(2)
  end

  def average_average_price_per_merchant
    test = @engine.csv_array(:merchants).sum do |merchant|
      average_item_price_for_merchant(merchant.id)
    end / @engine.number_of_class(:merchants)
    test.round(2)
  end

  def average_item_price
    test = @engine.csv_array(:items).sum do |item|
      item.unit_price
    end / @engine.number_of_class(:items)
    test.round(2)
  end

  def item_price_standard_deviation
    item_average = average_item_price
    item_array = @engine.csv_array(:items).map do |item|
      item.unit_price
    end
    standard_deviation(item_array, item_average)
  end

  def golden_items
    two_standard = average_item_price + item_price_standard_deviation * 2
    @engine.csv_array(:items).find_all do |item|
      item.unit_price > two_standard
    end
  end

  def average_invoices_per_merchant
    @engine.number_of_class(:invoices).fdiv(@merchant_id_array.length).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant

    merchant_invoice = @merchant_id_array.map do |merchant|
      @engine.csv_array(:invoices).count do |invoice|
        invoice.merchant_id == merchant
      end
    end

    standard_deviation(merchant_invoice, average)
  end

  def invoices_per_merchant
    invoice_count = @merchant_id_array.map do |merchant|
      @engine.csv_array(:invoices).count do |invoice|
        invoice.merchant_id == merchant
      end
    end

    @merchant_id_array.zip(invoice_count)
  end

  def invoices_per_day
    days = [0, 1, 2, 3, 4, 5, 6]

    days.map do |day|
      @engine.csv_array(:invoices).count do |invoice|
        invoice.created_at.wday == day
      end
    end
  end

  def find_extreme_merchants(top_or_bottom)
    merchant_invoice_array = invoices_per_merchant
    if top_or_bottom == 'top'
      deviation = (average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation * 2).round(2)
      extreme_merchant_count_pair = merchant_invoice_array.find_all do |invoice|
        invoice[1] > deviation
      end
    else
      deviation = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
      extreme_merchant_count_pair = merchant_invoice_array.find_all do |invoice|
        invoice[1] < deviation
      end
    end
    extreme_merchant_ids = extreme_merchant_count_pair.map do |merchant|
      merchant[0]
    end

    @engine.csv_array(:merchants).find_all do |merchant|
      extreme_merchant_ids.include?(merchant.id)
    end
  end

  def top_merchants_by_invoice_count
    find_extreme_merchants('top')
  end

  def bottom_merchants_by_invoice_count
    find_extreme_merchants('bottom')
  end

  def top_days_by_invoice_count
    days_of_week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    invoice_per_day = invoices_per_day
    average = invoice_per_day.sum.fdiv(7)

    days_div = standard_deviation(invoice_per_day, average)
    days_invoice = days_of_week.zip(invoice_per_day)

    golden_days = days_invoice.find_all do |(_day, invoice_number)|
      invoice_number > average + days_div
    end

    golden_days.map do |day, _invoice_number|
      day
    end
  end

  def invoice_status(status_arg)
    invoice_count = @engine.invoices.all.count do |invoice|
      invoice.status == status_arg
    end

    (invoice_count.fdiv(@engine.number_of_class(:invoices)) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    tr = @engine.transactions.find_all_by_invoice_id(invoice_id)
    successful_transactions = tr.find_all do |transaction|
      transaction.result == :success
    end
    successful_transactions.empty? != true
  end

  def invoice_total(invoice_id)
    items = @engine.invoice_items.find_all_by_invoice_id(invoice_id)

    items.map do |item|
      item.quantity * item.unit_price_to_dollars
    end.sum
  end

  def invoice_paid_in_full?(invoice_id)
    tr = @engine.transactions.find_all_by_invoice_id(invoice_id)
    successful_transactions = tr.find_all do |transaction|
      transaction.result == :success
    end
    successful_transactions.empty? != true
  end

  def invoice_total(invoice_id)
    items = @engine.invoice_items.find_all_by_invoice_id(invoice_id)

    total = items.map do |item|
      item.quantity * item.unit_price_to_dollars
    end.sum
    BigDecimal(total, 10)
  end

  def total_revenue_by_date(date)
    invoice_on_date = @engine.invoices.find_all_by_date(date)
    invoice_items_from_date = @engine.csv_array(:invoice_items).find_all do |invoice_item|
      invoice_on_date.include?(invoice_item.invoice_id)
    end

    total_revenue = invoice_items_from_date.sum do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end

    total_revenue.round(2)
  end

  def top_revenue_earners(search_range = 20)
    merchant_revenue_array = all_revenue_by_merchant

    sorted_merchant_array = merchant_revenue_array.sort_by do |(_merchant, revenue)|
      revenue
    end.reverse

    sorted_merchant_array.map do |(merchant, _revenue)|
      @engine.merchants.find_by_id(merchant)
    end[0..(search_range - 1)]
  end

  def merchants_with_pending_invoices
    transaction_per_invoice_id = @engine.transactions.transactions_by_invoice
    result_per_invoice = transaction_per_invoice_id.each_with_object([]) do |(invoice_wanted, transaction_array), array|
      if transaction_array != []
        transaction_result_array = transaction_array.map {|transaction| transaction.result}
        array << [invoice_wanted, transaction_result_array]
      else
        array << [invoice_wanted, [:failed]]
      end
    end

    invoice_id_pending = result_per_invoice.map do |(invoice_id, transaction_result)|
      if !transaction_result.include?(:success)
        invoice_id
      end
    end.compact

    invoice_id_pending.map do |invoice|
      @engine.merchants.find_by_id(invoice.merchant_id)
    end.uniq
  end

  def merchants_with_only_one_item
    items_grouped_by_merchant = @engine.items.all.group_by do |item|
      item.merchant_id
    end

    merchant_id_one_item = []
    items_grouped_by_merchant.each do |merchant_id, items_array|
      if items_array.length == 1
        merchant_id_one_item << merchant_id
      end
    end

    merchant_id_one_item.map do |merchant_id|
      @engine.merchants.find_by_id(merchant_id)
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    month_numeral = Time.parse(month).mon
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.mon == month_numeral
    end
  end

  def all_revenue_by_merchant
    merchant_invoice_array = @engine.invoices.invoices_by_merchant
    merchant_invoice_array.map do |(merchant, invoice_array)|
      [merchant, invoice_array.sum do |invoice_id|
        if invoice_paid_in_full?(invoice_id)
          invoice_total(invoice_id)
        else
          0
        end
      end]
    end
  end

  def revenue_by_merchant(merchant_id_wanted)
    wanted_merchant = all_revenue_by_merchant.find do |(merchant_id, revenue)|
      merchant_id == merchant_id_wanted
    end
    wanted_merchant[1]
  end

  def most_sold_item_for_merchant(merchant_id)
    invoice_array = @engine.invoices.find_all_by_merchant_id(merchant_id)
    invoice_item_array = invoice_array.flat_map do |invoice|
      @engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    items_by_quantity_sold = invoice_item_array.each_with_object({}) do |invoice_item, hash|
      if hash[invoice_item.item_id].nil?
        hash[invoice_item.item_id] = invoice_item.quantity
      else
        hash[invoice_item.item_id] + invoice_item.quantity
      end
    end.to_a

    hightest_quantity_sold = items_by_quantity_sold.max_by { |(_item_id, quantity)| quantity }[1]

    most_sold_item_id = items_by_quantity_sold.find_all do |(_item, quantity)|
      quantity == hightest_quantity_sold
    end

    most_sold_item_id.map do |(item_id_test, _quantity)|
      @engine.items.find_by_id(item_id_test)
    end
  end

  def best_item_for_merchant(merchant_id)
    invoice_array = @engine.invoices.find_all_by_merchant_id(merchant_id)

    paid_invoice_array = invoice_array.find_all do |invoice|
      invoice_paid_in_full?(invoice.id)
    end

    invoice_item_array = paid_invoice_array.flat_map do |invoice|
      @engine.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    items_by_quantity_sold = invoice_item_array.each_with_object({}) do |invoice_item, hash|
      if hash[invoice_item.item_id].nil?
        hash[invoice_item.item_id] = invoice_item.quantity * invoice_item.unit_price_to_dollars
      else
        hash[invoice_item.item_id] + invoice_item.quantity * invoice_item.unit_price_to_dollars
      end
    end.to_a

    hight_grossing_item_array = items_by_quantity_sold.max_by do |(_item_id, revenue)|
      revenue
    end

    @engine.items.find_by_id(hight_grossing_item_array[0])
  end
end
