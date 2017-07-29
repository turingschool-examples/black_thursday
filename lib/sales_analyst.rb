require_relative 'item_repo'
require_relative 'merchant_repo'

class SalesAnalyst

  include Math

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    merchant = @engine.merchants.all
    items    = @engine.items.all
    average = (items.length.to_f)/(merchant.length)
    average.round(2)
  end


   def average_items_per_merchant_standard_deviation
    mean = average_items_per_merchant
    actual_diff = subtract_mean_from_actual(mean)
    squared_diff = square_all_elements(actual_diff)
    sum = squared_diff.reduce(:+)
    sum_divided = sum/(return_array_of_items_by_merchant.length - 1)
    Math.sqrt(sum_divided).round(2)
   end

   def return_array_of_items_by_merchant
     @engine.merchants.all.map do |merchant|
       @engine.find_items_by_merchant_id(merchant.id).length
     end
   end

   def merchants_with_high_item_count
     std_dev = average_items_per_merchant_standard_deviation
     @engine.merchants.all.find_all do |merchant|
       (merchant.items.count - average_items_per_merchant) > std_dev
     end
   end


  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    price_total = price_totaler(merchant)
    return 0 if merchant.items.empty?
    (price_total / merchant.items.count).round(2)
  end

  def average_average_price_per_merchant
    total_average = @engine.merchants.all.reduce(0) do |sum, merchant|
      sum + average_item_price_for_merchant(merchant.id)
    end
    (total_average / @engine.merchants.all.count).round(2)
  end

  def item_price_totaler(total_items)
    @engine.items.all.reduce(0) do |sum, item|
      sum + item.unit_price
    end
  end

  def average_item_price
    total_items = @engine.items.all.count
    total_price = item_price_totaler(total_items)
    (total_price / total_items).round(2)
  end

  def average_item_price_standard_deviation
    jerry = @engine.items.all.reduce(0) do |sum, item|
      sum + (item.unit_price - average_item_price)**2
    end
    bob = jerry / (@engine.items.all.count - 1)
    (Math.sqrt(bob)).round(2)
  end

  def golden_items
    std_dev = average_item_price_standard_deviation
    average = average_average_price_per_merchant
    @engine.items.all.find_all do |item|
      (item.unit_price - average) > (2 * std_dev)
    end
  end
  #
  # def average_invoices_per_merchant
  # #   it "#average_invoices_per_merchant returns average number of invoices per merchant" do
  # #  expected = sales_analyst.average_invoices_per_merchant
  # #
  # #  expect(expected).to eq 10.49
  # #  expect(expected.class).to eq Float
  # end
  #
  # def average_invoices_per_merchant_standard_deviation
  # # it "#average_invoices_per_merchant_standard_deviation returns the standard deviation" do
  # # expected = sales_analyst.average_invoices_per_merchant_standard_deviation
  # #
  # # expect(expected).to eq 3.29
  # # expect(expected.class).to eq Float
  # end
  #
  # def top_merchants_by_invoice_count
  # # it "#top_merchants_by_invoice_count returns merchants that are two standard deviations above the mean" do
  # #  expected = sales_analyst.top_merchants_by_invoice_count
  # #
  # #  expect(expected.length).to eq 12
  # #  expect(expected.first.class).to eq Merchant
  # end
  #
  # def bottom_merchants_by_invoice_count
  # # it "#bottom_merchants_by_invoice_count returns merchants that are two standard deviations below the mean" do
  # # expected = sales_analyst.bottom_merchants_by_invoice_count
  # #
  # # expect(expected.length).to eq 4
  # # expect(expected.first.class).to eq Merchant
  # end
  #
  # def top_days_by_invoice_count
  # #   it "#top_days_by_invoice_count returns days with an invoice count more than one standard deviation above the mean" do
  # # expected = sales_analyst.top_days_by_invoice_count
  # #
  # # expect(expected.length).to eq 1
  # # expect(expected.first).to eq "Wednesday"
  # # expect(expected.first.class).to eq String
  # end
  #
  # def invoice_status(:pending)
  # #   it "#invoice_status returns the percentage of invoices with given status" do
  # # expected = sales_analyst.invoice_status(:pending)
  # #
  # # expect(expected).to eq 29.55
  # end
  #
  # def invoice_status(:shipped)
  # # expected = sales_analyst.invoice_status(:shipped)
  # #
  # # expect(expected).to eq 56.95
  # end
  #
  # def invoice_status(:returned)
  # #
  # # expected = sales_analyst.invoice_status(:returned)
  # #
  # # expect(expected).to eq 13.5
  # end

  private

    def price_totaler(merchant)
      merchant.items.reduce(0) do |sum, item|
        sum + item.unit_price
      end
    end

    def subtract_mean_from_actual(mean)
      return_array_of_items_by_merchant.map do |merchant_items|
        merchant_items - mean
      end
    end

    def square_all_elements(actual_diff)
      actual_diff.map! do |num|
        num ** 2
      end
    end

end
