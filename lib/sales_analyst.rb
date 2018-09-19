require 'pry'

class SalesAnalyst
  attr_reader :ir,
              :mr,
              :inv_repo,
              :ii,
              :tr

  def initialize(merchant_repository, item_repository, inv_repo, inv_items_repo, transaction_repo)
      @mr = merchant_repository
      @ir = item_repository
      @inv_repo = inv_repo
      @ii = inv_items_repo
      @tr = transaction_repo
  end

  def average_items_per_merchant
    sum = summed(@ir.objects_array)
    (sum.to_f/@mr.all.count).round(2)
  end

  def summed(array)
    array.reduce(0) do |sum, item|
      sum + 1
    end
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    merchant_items = items_per_merchant
    individual_dev = items_per_merchant_deviation(merchant_items, average)
    each_squared = squared(individual_dev)
    standard_deviation(each_squared)
  end

  def items_per_merchant
    @ir.objects_array.group_by do |item|
      item.merchant_id
    end
  end

  def items_per_merchant_deviation(items_per_merchant, average)
    items_per_merchant.map do | id, items |
      items.count - average
    end
  end

  def squared(deviation_array)
    deviation_array.map do | deviation |
      deviation ** 2
    end
  end

  def standard_deviation(squared)
    squaresum = squared.reduce(0) do |sum, square|
      sum + square
    end
    (Math.sqrt(squaresum/(squared.length - 1))).round(2)
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    merchants_hash = items_per_merchant.select do |id, items|
      (items.count - average) >= 3.26
    end
    @mr.objects_array.find_all do |merchant|
      merchants_hash.include?(merchant.id)
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items_list = @ir.find_all_by_merchant_id(merchant_id)
    prices = items_list.map { |item| item.unit_price }
    sum_of_item_prices = summed_prices(prices)
    (sum_of_item_prices/prices.count).round(2)
  end

  def summed_prices(array)
    array.reduce(0) do |sum, item|
      sum + item
    end
  end

  def average_average_price_per_merchant
    merchant_id_array = @mr.objects_array.map { |merchant| merchant.id }
    average_price_list = merchant_id_array.map do |merchant_id|
      average_item_price_for_merchant(merchant_id)
    end
    price_sum = summed_prices(average_price_list)
    (price_sum/average_price_list.count).round(2)
  end

  def golden_items
    average_price = average_average_price_per_merchant
    array_of_prices_subtracted = price_minus_average_price(average_price)
    prices_stnd_dev = price_standard_deviation(array_of_prices_subtracted)
    expensive_items(prices_stnd_dev)
  end

  def price_standard_deviation(prices_subtracted)
    squared_prices_subtracted = squared(prices_subtracted)
    standard_deviation(squared_prices_subtracted)
  end

  def price_minus_average_price(average_price)
    prices = @ir.objects_array.map { |item| item.unit_price}
    prices_subtracted = prices.map do |price|
      (price - average_price)
    end
  end

  def expensive_items(stnd_dev)
    @ir.objects_array.find_all { |item| item.unit_price >= 5805.38 }
  end

  def average_invoices_per_merchant
    all_invoices = @inv_repo.all.count
    all_merchants = @mr.all.count
    (all_invoices.to_f/all_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average_inv = average_invoices_per_merchant
    invoices_subtracted = merchant_invoices_minus_average_invoices(average_inv)
    squared_subtracted_invoices = squared(invoices_subtracted)
    standard_deviation(squared_subtracted_invoices)
  end

  def merchant_invoices_minus_average_invoices(average_invoices)
    merchant_ids_and_count = count_duplicates
    merchant_ids_and_count.values.map do |dup_count|
      (dup_count - average_invoices)
    end
  end

  def number_of_invoice_per_merchant
    @inv_repo.objects_array.map do |invoice|
      invoice.merchant_id
    end
  end

  def count_duplicates
    merchant_invoice_count = {}
    merchant_id_array = number_of_invoice_per_merchant
    @mr.all.each do |merchant|
      number = merchant_id_array.count(merchant.id)
      merchant_invoice_count[merchant] = number
    end
    merchant_invoice_count
  end

  def top_merchants_by_invoice_count
    average_count = average_invoices_per_merchant
    merchants_invoice_count = count_duplicates
    merchant_hash = merchants_invoice_count.select do |invoice, count|
      (count - average_count) > 6.58
    end
    merchant_hash.keys
  end

  def bottom_merchants_by_invoice_count
    average_count = average_invoices_per_merchant
    merchants_invoice_count = count_duplicates
    merchant_hash = merchants_invoice_count.select do |invoice, count|
      (count - average_count) < -6.58
    end
    merchant_hash.keys
  end

  def top_days_by_invoice_count
    stdn_dev = standard_deviation_of_invoices_per_day
    days_hash = number_of_invoices_per_day
    average = average_total_invoices_per_day(days_hash)
    days_hash = days_hash.select do |day, invoice_total|
      (invoice_total - average) > stdn_dev
    end
    number = days_hash.keys.flatten
    to_days(number)
  end

  def standard_deviation_of_invoices_per_day
    days_hash = number_of_invoices_per_day
    avg = average_total_invoices_per_day(days_hash)
    days_array = days_hash.values
    dev_array = subtract_avg_inv_per_day_from_day_total(days_array, avg)
    squared_array = squared(dev_array)
    standard_deviation(squared_array)
  end

  def dates_to_days_of_week
    @inv_repo.objects_array.map do |invoice|
      invoice.created_at.wday
    end
  end

  def number_of_invoices_per_day
    array_of_days = dates_to_days_of_week
    days_and_totals = (0..6).group_by { |day| array_of_days.count(day)}.invert
  end

  def average_total_invoices_per_day(days_hash)
    array_of_totals = days_hash.values
    all_total = summed_prices(array_of_totals)
    avg = (all_total/7.0)
  end

  def subtract_avg_inv_per_day_from_day_total(totals_array, average)
    totals_array.map { |total| total - average }
  end

  def to_days(numbers)
    days = {0 => 'Sunday', 1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday',
      4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday'}
      numbers.map { |number| days[number]}
  end

  def invoice_status(status)
    invoices = group_invoices_by_status
    all_invoices = @inv_repo.all.count
    ((invoices[status].count/all_invoices.to_f) * 100).round(2)
  end

  def group_invoices_by_status
    @inv_repo.objects_array.group_by do |invoice|
      invoice.status
    end
  end

  def invoice_paid_in_full?(invoice_id)
    transactions = @tr.find_all_by_invoice_id(invoice_id)
    return false if transactions[0] == nil
    if transactions.any? { |transaction| transaction.result == :success }
      true
    else
      false
    end
  end


  def invoice_total(invoice_id)
    if invoice_paid_in_full?(invoice_id)
      invoice_items = @ii.find_all_by_invoice_id(invoice_id)
      totals_array = multiply_unit_price_and_quantity(invoice_items)
      summed_prices(totals_array)
    end
  end

  def multiply_unit_price_and_quantity(invoice_items)
    invoice_items.map do |invoice_item|
      BigDecimal.new(invoice_item.unit_price) * invoice_item.quantity
    end
  end

  def total_revenue_by_date(date)
    invoices_for_date = @inv_repo.objects_array.group_by do |invoice|
      invoice.created_at.strftime("%Y%m%d")
    end
    specific_date_invoices = invoices_for_date[date.strftime("%Y%m%d")]
    invoice_items = specific_date_invoices.map do |invoice|
      @ii.find_all_by_invoice_id(invoice.id)
    end
    succesful_transactions = invoice_items.flatten.find_all do |invoice_item|
      invoice_paid_in_full?(invoice_item.invoice_id)
    end
    multiplied = multiply_unit_price_and_quantity(succesful_transactions)
    summed_prices(multiplied)
  end

  def top_revenue_earners(number = 20)
    hash = merchant_invoice_totals
    top_merchants = hash.max_by(number) { |key, value| value }
    top_merchants.map { |merchant| @mr.find_by_id(merchant[0]) }
  end

  def invoices_by_merchant
    @inv_repo.objects_array.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def merchant_invoice_totals
    hash = invoices_by_merchant
    hash.each do |merchant_id, invoice_array|
      hash[merchant_id] = sum_total_invoice_array(invoice_array)
    end
    hash
  end

  def sum_total_invoice_array(invoice_array)
    invoice_total_array = invoice_array.map do |invoice|
      invoice_total(invoice.id)
    end
    summed_prices(invoice_total_array.compact)
  end

  def merchants_with_pending_invoices
    invoices_array = @inv_repo.objects_array.map do |invoice|
      succesful_invoices(invoice.id)
    end
    merchants_array = invoices_array.compact.map do |invoice|
      @mr.find_by_id(invoice.merchant_id)
    end
    merchants_array.uniq
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(@mr.objects_array.count)
  end

  def pending?(invoice_id)
    transactions = @tr.find_all_by_invoice_id(invoice_id)
    return false if transactions[0] == nil
    if transactions.any? { |transaction| transaction.result == :success }
      true
    else
      false
    end
  end

  def succesful_invoices(invoice_id)
    transactions = @tr.find_all_by_invoice_id(invoice_id)
    if transactions.all? { |transaction| transaction.result == :failed }
      @inv_repo.find_by_id(invoice_id)
    end
  end

  def merchants_with_only_one_item
    merchants_items = @ir.objects_array.group_by do |item|
      @mr.find_by_id(item.merchant_id)
    end
    single_item_merchants = merchants_items.select do |merchant, items|
      items.count == 1
    end
    single_item_merchants.keys
  end

  def merchants_with_only_one_item_registered_in_month(month)
    one_item_merchants = merchants_with_only_one_item
    one_item_merchants.find_all do |merchant|
      created_month = Time.parse(merchant.created_at).month
      created_month == months_to_numbers(month)
    end
  end

  def months_to_numbers(month)
    months = {january: 1, febuary: 2, march: 3, april: 4, may: 5, june: 6,
              july: 7, august: 8, september: 9, october: 10, november: 11,
              december: 12}
    months[month.downcase.to_sym]
  end

  def revenue_by_merchant(merchant_id)
    merchant = @mr.find_by_id(merchant_id)
    merchants_with_invoices = invoices_by_merchant
    merchant_invoices = merchants_with_invoices[merchant.id]
    sum_total_invoice_array(merchant_invoices)
  end

  def most_sold_item_for_merchant(merchant_id)
    grouped_invoices_with_merchant = invoices_by_merchant
    specific_merchant_invoices = grouped_invoices_with_merchant[merchant_id]
    invoice_items_array = specific_merchant_invoices.map do |invoice|
      @ii.find_all_by_invoice_id(invoice.id)
    end
    item_id_to_inv_item = invoice_items_array.flatten.group_by do |invoice_item|
      invoice_item.item_id
    end
    hash = {}
    item_id_to_inv_item.each do |item_id, invoice_items|
      top_invoice = invoice_items.max_by do |inv_item|
        inv_item.quantity
      end
      hash[item_id] = top_invoice
    end
    top_item = hash.max_by { |item_id, invoice_item| invoice_item.quantity }
    item_ids_array = hash.map do |invoice_id, invoice_item|
      @ir.find_by_id(invoice_id) if top_item[1].quantity == invoice_item.quantity
    end
    item_ids_array.compact
  end

end
