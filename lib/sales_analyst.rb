require_relative 'item_repo'
require_relative 'merchant_repo'
require_relative 'invoice_repo'

class SalesAnalyst

  include Math

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_item_price
    total_items = engine.items.all.count
    total_price = item_price_totaler(total_items)
    (total_price / total_items).round(2)
  end

  def average_items_per_merchant
    merchant = engine.merchants.all
    items    = engine.items.all
    average  = (items.length.to_f)/(merchant.length)
    average.round(2)
  end

  def average_invoices_per_day
    engine.invoices.all.length/7
  end

  def average_items_per_merchant_standard_deviation
    mean         = average_items_per_merchant
    actual_diff  = subtract_mean_from_actual(mean, array_of_items_by_merchant)
    squared_diff = square_all_elements(actual_diff)
    sum          = squared_diff.reduce(:+)
    sum_divided  = sum/(array_of_items_by_merchant.length - 1)
    Math.sqrt(sum_divided).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean         = average_invoices_per_merchant
    act_diff     = subtract_mean_from_actual(mean,array_of_invoices_by_merchant)
    squared_diff = square_all_elements(act_diff)
    sum          = squared_diff.reduce(:+)
    sum_divided  = sum/(array_of_invoices_by_merchant.length - 1)
    Math.sqrt(sum_divided).round(2)
  end

  def average_item_price_standard_deviation
    sq_total = find_standard_deviation_of_averages/(engine.items.all.count - 1)
    (Math.sqrt(sq_total)).round(2)
  end

  def average_invoices_per_day_standard_deviation
    mean         = average_invoices_per_day
    actual_diff  = subtract_mean_from_actual(mean, array_of_invoices_by_day)
    squared_diff = square_all_elements(actual_diff)
    sum          = squared_diff.reduce(:+)
    sum_divided  = sum/(array_of_invoices_by_day.length - 1)
    Math.sqrt(sum_divided).round(2)
  end

  def array_of_invoices_by_merchant
    engine.merchants.all.map do |merchant|
      engine.find_invoices_by_merchant_id(merchant.id).length
    end
  end

  def array_of_invoices_by_day
    days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday',
            'Friday', 'Saturday', 'Sunday']
    days.map do |day|
      invoices_per_day(day).length
    end
  end

  def array_of_items_by_merchant
    engine.merchants.all.map do |merchant|
      engine.find_items_by_merchant_id(merchant.id).length
    end
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    engine.merchants.all.find_all do |merchant|
      (merchant.items.count - average_items_per_merchant) > std_dev
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant    = engine.merchants.find_by_id(merchant_id)
    price_total = price_totaler(merchant)
    return 0 if merchant.items.empty?
    (price_total / merchant.items.count).round(2)
  end


  def average_average_price_per_merchant
    total_average = engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total_average / engine.merchants.all.count).round(2)
  end

  def golden_items
    std_dev = average_item_price_standard_deviation
    average = average_average_price_per_merchant
    find_golden_items(std_dev, average)
  end

  def average_invoices_per_merchant
    merchant = engine.merchants.all
    invoices = engine.invoices.all
    average  = (invoices.length.to_f)/(merchant.length)
    average.round(2)
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    mean    = average_invoices_per_merchant
    find_top_merchants_by_invoice_count(std_dev, mean)
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    mean    = average_invoices_per_merchant
    find_bottom_merchants_by_invoice_count(std_dev, mean)
  end

  def top_days_by_invoice_count
    std_dev = average_invoices_per_day_standard_deviation
    mean    = average_invoices_per_day
    days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday',
            'Friday', 'Saturday', 'Sunday']
    find_top_days(days, mean, std_dev)
  end

  def invoice_status(status)
    invoice_status = status_iterator(status).length.to_f
    total   = engine.invoices.all.length.to_f
    percentage = (invoice_status/total) * 100
    percentage.round(2)
  end

  def total_revenue_by_date(date)
    # returns an amount in dollars
    invoices = engine.invoices.all
    invoices_by_date = invoices.find_all do |invoice|
      invoice.created_at == date
    end
    sum = 0
    invoices_items = invoices_by_date.map do |invoice|
      engine.find_invoice_items_by_invoice(invoice.id)
    end
    invoices_items.flatten!
    invoices_items.each do |invoice_item|
      sum += (invoice_item.unit_price * invoice_item.quantity.to_f)
    end
    sum
  end

  def top_revenue_earners(x = 20)
    sorted_merchants = sort_merchants_by_revenue
    top_merchants = sorted_merchants.last(x)
    top_merchants.reverse
  end

  def sort_merchants_by_revenue
    merchants = @engine.merchants.all
    merchants.sort_by {|merchant| merchant.total_revenue}
  end

  def merchants_ranked_by_revenue
    sort_merchants_by_revenue.reverse
  end

  def merchants_with_pending_invoices
    merchants = @engine.merchants.all
    pending_array = []
    merchants.each do |merchant|
      if merchant.pending_invoices?
        pending_array << merchant
      end
    end
    pending_array
  end

  def revenue_by_merchant(merchant_id)
    merchant = @engine.find_merchant_by_id(merchant_id)
    merchant.total_revenue
  end

  def find_merchants_by_invoice(invoices)
    invoices.map do |invoice|
      @engine.find_merchant_by_id(invoice.merchant_id)
    end
  end

  def merchants_with_only_one_item
    engine.merchants_with_only_one_item
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all  do |merchant|
      merchant.created_at.strftime('%B') == month
    end
  end

<<<<<<< HEAD
  # def revenue_by_merchant(merchant_id)
  #   @engine.merchants_by_total_revenue(merchant_id)
  # end
=======
  def revenue_by_merchant(merchant_id)
    engine.merchants_by_total_revenue(merchant_id)
  end
>>>>>>> master

  def most_sold_item_for_merchant(merchant_id)
    merchant = engine.find_merchant_by_id(merchant_id)
    most_sold = merchant.invoice_items.reduce({}) do |quantities, invoice_item|
      quantity = invoice_item.quantity.to_i
      if quantities.has_key?(quantity)
        quantities[quantity] << engine.find_item_by_id(invoice_item.item_id)
      else
        quantities[quantity] = [engine.find_item_by_id(invoice_item.item_id)]
      end
      quantities
    end
    most_sold[most_sold.keys.max]
  end

  def best_item_for_merchant(merchant_id)
    merchant = engine.find_merchant_by_id(merchant_id)
    best_items = merchant.invoice_items.reduce({}) do |quantities, inv_item|
      revenue = inv_item.quantity * inv_item.unit_price
      quantities[revenue] = engine.find_item_by_id(inv_item.item_id)
      quantities
    end
    best_items[best_items.keys.max]
  end
  #i hate github
  private

    def find_top_days(days, mean, std_dev)
      days.find_all do |day|
        (invoices_per_day(day).length - mean) > (std_dev)
      end
    end

    def time_converter(invoice)
      invoice.created_at.strftime "%A"
    end

    def invoices_per_day(day)
      engine.invoices.all.find_all do |invoice|
        (day == time_converter(invoice))
      end
    end

    def status_iterator(status)
      engine.invoices.all.find_all do |invoice|
        invoice.status == status
      end
    end

    def find_standard_deviation_of_averages
      engine.items.all.reduce(0) do |sum, item|
        sum + (item.unit_price - average_item_price) ** 2
      end
    end

    def find_golden_items(std_dev, average)
      engine.items.all.find_all do |item|
        (item.unit_price - average) > (2 * std_dev)
      end
    end

    def find_top_merchants_by_invoice_count(std_dev, average)
      engine.merchants.all.find_all do |merchant|
        (engine.find_invoices_by_merchant_id(merchant.id).length - average) > (std_dev * 2)
      end
    end

    def find_bottom_merchants_by_invoice_count(std_dev, average)
      engine.merchants.all.find_all do |merchant|
        (engine.find_invoices_by_merchant_id(merchant.id).length + (std_dev * 2)) < (average)
      end
    end

    def item_price_totaler(total_items)
      engine.items.all.reduce(0) do |sum, item|
        sum + item.unit_price
      end
    end

    def price_totaler(merchant)
      merchant.items.reduce(0) do |sum, item|
        sum + item.unit_price
      end
    end

    def subtract_mean_from_actual(mean, sorted_array)
      sorted_array.map do |merchant_items|
        merchant_items - mean
      end
    end

    def square_all_elements(actual_diff)
      actual_diff.map do |num|
        num ** 2
      end
    end

end
