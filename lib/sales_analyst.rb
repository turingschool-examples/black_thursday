require 'pry'
require 'bigdecimal'
require 'bigdecimal/util'
class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (@sales_engine.items.repo.count.to_f / @sales_engine.merchants.repo.count).round(2)
  end

  def average_items_per_merchant_standard_deviation
    diff_squared =
    differences_squared(items_per_merchant_hash.values,average_items_per_merchant)
    summed = sum_values(diff_squared)
    divided_sum = summed / (items_per_merchant_hash.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def items_per_merchant_hash
    merchant_id_array.inject(Hash.new(0)) do |total, id|
      total[id] += 1
      total
    end
  end

  def merchant_id_array
    merchant_ids = @sales_engine.items.repo.map do |item|
      item.merchant_id
    end
  end

  def merchants_with_high_item_count
    highest_count = items_per_merchant_hash.find_all do |merchant|
      merchant[1] > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
    highest_count.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant[0])
    end
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    summed_unit_price = items.inject(0) do |sum,item|
      sum + item.unit_price
    end
    (summed_unit_price/items.count).round(2)
  end

  def average_average_price_per_merchant
    average_of_all_merchants = items_per_merchant_hash.map do |merchant|
      average_item_price_for_merchant(merchant[0])
    end
    summed = sum_values(average_of_all_merchants)
    (summed / @sales_engine.merchants.repo.count).round(2)
  end

  def average_item_cost
    summed = sum_values(array_of_unit_price)
    # binding.pry
    (summed / @sales_engine.items.repo.count).round(2)
  end

  def golden_items_standard_deviation
    differences_squared = @sales_engine.items.repo.map do |item|
      (item.unit_price - average_item_cost) ** 2
    end
    summed = sum_values(differences_squared)
    divided_sum = summed / (@sales_engine.items.repo.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def golden_items
    avg = average_item_cost
    dev = golden_items_standard_deviation * 2
    golden_benchmark = avg + dev

  @sales_engine.items.repo.find_all do |item|
      item.unit_price > golden_benchmark
    end
  end

  def array_of_unit_price
    @sales_engine.items.repo.map do |item|
      item.unit_price
    end
  end

  def differences_squared(nums_array,average)
    nums_array.map do |number|
    (number - average) ** 2
    end
  end

  def sum_values(array)
    array.inject(0) do |sum,num|
      sum + num
    end
  end

  def average_invoices_per_merchant
    (@sales_engine.invoices.repo.count / @sales_engine.merchants.repo.count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    diff_squared = differences_squared(invoice_per_merchant_hash.values, average_invoices_per_merchant)

    summed = sum_values(diff_squared)
    divided_sum = summed / (invoice_per_merchant_hash.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def invoice_per_merchant_hash
    merchant_id_array_for_invoices.inject(Hash.new(0)) do |total, merchant_id|
      total[merchant_id] += 1
      total
    end
  end

  def merchant_id_array_for_invoices
    merchant_ids = @sales_engine.invoices.repo.map do |invoice|
      invoice.merchant_id
    end
  end

  def top_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    dev = average_invoices_per_merchant_standard_deviation * 2
    golden_benchmark = avg + dev
    top_merchants = invoice_per_merchant_hash.find_all do |merchant_id, invoice_count|
      invoice_count > golden_benchmark
    end
    top_merchants.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant[0])
    end
  end

  def bottom_merchants_by_invoice_count
    avg = average_invoices_per_merchant
    dev = average_invoices_per_merchant_standard_deviation * 2
    golden_benchmark = avg - dev
    top_merchants = invoice_per_merchant_hash.find_all do |merchant_id, invoice_count|
      invoice_count < golden_benchmark
    end
    top_merchants.map do |merchant|
      @sales_engine.merchants.find_by_id(merchant[0])
    end
  end

  def invoice_status(status_symbol)
    status_count = @sales_engine.invoices.repo.find_all do |invoice|
      invoice.status == status_symbol
    end
    (status_count.count.to_f/@sales_engine.invoices.repo.count * 100).round(2)
  end

  def time_to_day(time)
    time.strftime("%A")
  end

  def day_and_invoice_count_hash
    @sales_engine.invoices.repo.inject(Hash.new(0)) do |total,invoice|
      total[time_to_day(invoice.created_at)] += 1
      total
    end
  end

  def average_invoice_per_day
    summed = sum_values(day_and_invoice_count_hash.values)
    (summed.to_f/day_and_invoice_count_hash.count).round(2)
  end

  def top_days_by_invoice_count
    avg = average_invoice_per_day
    dev = average_day_per_invoice_standard_deviation
    benchmark = avg + dev
    top_days = day_and_invoice_count_hash.find_all do |merchant_id, invoice_count|
      invoice_count > benchmark
    end
    top_days.map do |day_count|
      day_count[0]
    end
  end

  def average_day_per_invoice_standard_deviation
    avg = average_invoice_per_day
    diff_squared = differences_squared(day_and_invoice_count_hash.values,avg)

    summed = sum_values(diff_squared)
    divided_sum = summed / (day_and_invoice_count_hash.count - 1)
    Math.sqrt(divided_sum).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    transactions_by_invoice = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    transactions_by_invoice.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoices = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    invoices.inject(0) do |sum, invoice|
      sum += invoice.unit_price * invoice.quantity
      sum
    end
  end

  def total_revenue_by_date(date)
    invoice_by_date = @sales_engine.invoices.repo.find_all do |invoice|
      invoice.created_at == date
    end
    total = invoice_by_date.map do |invoice|
      invoice_total(invoice.id)
    end
    total[0]
  end

  def merchants_with_pending_invoices
    pending_invoices = @sales_engine.invoices.repo.find_all do |invoice|
      invoice.status == :pending
    end
    pending_invoices.map do |invoice|
      @sales_engine.merchants.find_by_id(invoice.merchant_id)
    end

  end

  def merchants_with_only_one_item
    one_item_merchants = items_per_merchant_hash.find_all do |merchant_id, items|
      items == 1
    end
    one_item_merchants.map do |merchant_id_array|
      @sales_engine.merchants.find_by_id(merchant_id_array[0])
    end
  end

  def items_per_merchant_hash
    merchant_id_array_for_items.inject(Hash.new(0)) do |total, merchant_id|
      total[merchant_id] += 1
      total
    end
  end

  def merchant_id_array_for_items
    merchant_ids = @sales_engine.items.repo.map do |item|
      item.merchant_id
    end
  end

  # def top_revenue_earners(x)
  #   item_id_price_hash = @sales_engine.invoice_items.repo.inject(Hash.new(0)) do |hash,invoice_item|
  #     hash[invoice_item.item_id] = invoice_item.unit_price
  #     hash
  #   end
  #   item_id_price_hash
  #   binding.pry
  # end
  #


  def inspect
   "#<#{self.class} #{@merchant.size} rows>"
  end

end
