require_relative 'items_repo'
require_relative 'merchant_repo'
require 'pry'
require 'bigdecimal'

class SalesAnalyst

  attr_reader :merchants, :items, :price, :invoices

  def initialize(sales_engine)
    # binding.pry
    @merchants     = sales_engine.merchants
    @items         = sales_engine.items
    @invoices      = sales_engine.invoices
  end

  def self.from_csv(sales_engine)
    new(sales_engine)
  end

  def average_items_per_merchant
    return @average_items if defined? @average_items
    average = @items.all_items.count.to_f
    average_1 = @merchants.all_merchants.count.to_f
    complete_average = average / average_1
    @average_items = complete_average.round(2)
    @average_items
  end

  def average_items_per_merchant_standard_deviation
    @merchant_deviations = @merchants.all_merchants.map do |merchant|
      (merchant.items.count - average_items_per_merchant)**2
    end
    Math.sqrt(@merchant_deviations.inject(0,:+) / @merchants.all_merchants.count).round(2)
  end

  def merchants_with_high_item_count

    @high_count = []
    @merchants.all_merchants.map do |merchant|
     if merchant.items.count >= 6.12
     @high_count << merchant
      else
      merchant
      end
    end
    @high_count
  end

  def average_item_price_for_merchant(merch_id)
    # merchant = @items.all_merchants.find {|merchant| merchant.id == merch_id }
    @totals = []
    total = @items.all_items.select {|item| item.merchant_id == merch_id }
    total.map do |t|
    @totals << t.price
    end
    total_average = (@totals.reduce(:+) / @totals.count) / 100
    total_average.round(2)
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

  def top_merchants_by_invoice_count
    top_merchants = invoices.all.map do |invoice|
      if invoice.merchant_id == invoice.merchant_id + average_invoices_per_merchant_standard_deviation * 2
        invoice
      end
    end
  end

end
