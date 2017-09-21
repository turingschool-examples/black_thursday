# require_relative 'items_repo'
# require_relative 'merchant_repo'
require_relative 'sales_engine'
require 'pry'
require 'bigdecimal'

class SalesAnalyst

  attr_reader :merchants, :items, :price, :invoices, :invoice_items, :transactions, :customers

  def initialize(sales_engine)
    @merchants     = sales_engine.merchants
    @items         = sales_engine.items
    @invoices      = sales_engine.invoices
    @invoice_items = sales_engine.invoice_items
    @transactions  = sales_engine.transactions
    @customers     = sales_engine.customers
  end

  def self.from_csv(sales_engine)
    new(sales_engine)
  end

  def total_items
   @items.all.count.to_f
  end

  def average_items_per_merchant
    return @average_items if defined? @average_items
    average = @items.all_items.count.to_f
    average_1 = @merchants.all_merchants.count.to_f
    complete_average = average / average_1
    @average_items = complete_average.round(2)
    @average_items
  end

  def total_merchants
    @merchants.all.count.to_f
  end

  def average_items_per_merchant_standard_deviation
    @merchant_deviations = @merchants.all_merchants.map do |merchant|
      (merchant.items.count - average_items_per_merchant)**2
    end
    Math.sqrt(@merchant_deviations.inject(0,:+) / @merchants.all_merchants.count).round(2)
  end

  def merchants_with_high_item_count
    @high_count = []
    @merchants.all_merchants.each do |merchant|
     if merchant.items.count >= 6.12
       @high_count << merchant
      else
        merchant
      end
    end
    @high_count
  end

  def average_item_price_for_merchant(merch_id)
    @totals = []
    total = @items.all_items.select {|item| item.merchant_id == merch_id }
      total.map do |t|
        @totals << t.price
      end
    total_average = (@totals.reduce(:+) / @totals.count) / 100
    total_average.round(2)
  end

  def average_average_price_per_merchant
    sum_of_averages = @merchants.all.reduce(0) do |sum, merchant|
    sum += average_item_price_for_merchant(merchant.id)
    end
    (sum_of_averages / total_merchants).round(2)
  end

  def average_invoices_per_merchant
    num_1 = invoices.all.count.to_f
    num_2 = merchants.all.count.to_f
    average = num_1 / num_2
    average.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    standard_dev = merchants.all.map do |merchant|
      (merchant.invoices.count - average_invoices_per_merchant)**2
    end
  Math.sqrt(standard_dev.inject(0,:+) / merchants.all.count).round(2)
  end

  def item_price_standard_deviation
    item_price = Proc.new {|item| item.unit_price}
    standard_deviation(average_item_price_for_merchant(merch_id),@items.all,item_price,total_items)
  end


  def top_merchants_by_invoice_count
    target = (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
    top_merchants = merchants.all.map do |merchant|
      if merchant.invoices.length > target
        merchant
      end
    end
    top_merchants.compact
  end

  def bottom_merchants_by_invoice_count
    target = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    bottom_merchants = merchants.all.map do |merchant|
      if merchant.invoices.length < target
        merchant
      end
    end
    bottom_merchants.compact
  end

  def average_invoices_per_weekday
      invoices.all.length / 7
  end

  def counts
    invoices.all.each_with_object(Hash.new(0)) do |invoice, count|
      count[invoice.weekday_time] += 1
    end
  end

  def whatever
    counts.each_value.map do |count|
      (count - invoices.all.length / 7) ** 2
    end
  end

  def top_days_by_invoice_count
    standard_dev = Math.sqrt(whatever.reduce(0,:+) / 6)
    target = average_invoices_per_weekday + standard_dev
    top_days = []
    counts.each_pair do |day, num|
      if num > target
        top_days << day
      end
    end
    top_days
  end

  def status_array
    invoices.all.map do |invoice|
      invoice.status
    end
  end

  def invoice_status(status)
    invoice_amount = invoices.all.length
    new_array = status_array.map do |unit|
      unit if unit == status
    end
    compacted = new_array.compact
    total = (compacted.length.to_f / invoice_amount.to_f) * 100
    total.round(2)
  end

  def merchants_with_only_one_item
    @merchants.all.select do |merchant|
      merchant.items.count == 1
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime('%B') == month
    end
  end

  def get_invoice_ids(invoices_on_date)
    invoices_on_date.map do |invoice|
    invoice.id
    end
  end

  def sum_invoice_items(invoice_items)
   invoice_items[0].map do |item|
     (item.unit_price * item.quantity.to_i)
   end.sum
  end

  def total_revenue_by_date(date)
   invoices_by_date = invoices.find_all_by_created_at(date)
   result = invoices_by_date.map do |invoice|
     invoice_items.find_all_by_invoice_id(invoice.id)
   end
   total = 0
   result.flatten.each do |item|
     total += item.quantity.to_i * item.unit_price
   end
   total
  end

end
