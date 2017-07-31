require_relative '../lib/sales_engine'
require_relative '../lib/invoice_analytics'
require_relative '../lib/market_analytics'
require_relative '../lib/customer_analytics'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
    @invoices = sales_engine.invoices
    @invoice_items = sales_engine.invoice_items
    @transactions = sales_engine.transactions
    @customers = sales_engine.customers
    if !(@invoices.nil?)
      include InvoiceAnalytics
    end
    if !(@invoice_items.nil?) && !(@transactions.nil?)
      include MarketAnalytics
    end
    if !(@customers.nil?)
      include CustomerAnalytics
    end
  end

  private

    def month_name_to_num
      {"January" => 01,
       "February" => 02,
       "March" => 03,
       "April" => 04,
       "May" => 05,
       "June" => 06,
       "July" => 07,
       "August" => 08,
       "September" => 09,
       "October" => 10,
       "November" => 11,
       "December" => 12}
     end

    def total_items
      @items.id_repo.count.to_f
    end

    def total_merchants
      @merchants.id_repo.count.to_f
    end

    def total_of_all_prices
      @items.price_repo.keys.reduce(0) do |price_sum, price|
        @items.find_all_by_price(price).count.times do
          price_sum += price
        end
        price_sum
      end
    end

    def standard_deviation(average, numerator_repo, numerator_attribute_proc, total)
      summed = numerator_repo.keys.reduce(0) do |sum, identifier|
        if !(numerator_repo[identifier].nil?)
          object = numerator_repo[identifier]
          attribute_value = numerator_attribute_proc.call(object)
          sum += (attribute_value - average) ** 2
        end
        sum
      end
      divided_result = summed / (total - 1)
      Math.sqrt(divided_result).round(2)
    end

  public

    def average_items_per_merchant
      (total_items / total_merchants).round(2)
    end

    def average_price_per_merchant
      (total_of_all_prices / total_merchants).round(2)
    end

    def average_item_price
      (total_of_all_prices / total_items).round(2)
    end

    def average_item_price_for_merchant(merchant_id)
      merchant = @merchants.find_by_id(merchant_id)
      if !(merchant.nil?)
        total = merchant.items.reduce(0) do |total_price, item|
          total_price += item.unit_price
        end
        average = (total / merchant.items.count).round(2)
      end
    end

    def average_items_per_merchant_standard_deviation
      count_items = Proc.new {|merchant| merchant.items.count}
      standard_deviation(average_items_per_merchant, @merchants.id_repo, count_items, total_merchants)
    end

    def item_price_standard_deviation
      item_price = Proc.new {|item| item.unit_price}
      standard_deviation(average_item_price, @items.id_repo, item_price, total_items)
    end

    def merchants_with_high_item_count
      standard_dev = average_items_per_merchant_standard_deviation
      @merchants.id_repo.keys.find_all do |id|
        merchant = @merchants.find_by_id(id)
        merchant.items.count > average_items_per_merchant + standard_dev
      end
    end

    def golden_items
      two_stndv_above_avg = (item_price_standard_deviation * 2) + average_item_price
      @items.price_repo.keys.reduce([]) do |results, price|
        if price >= two_stndv_above_avg
          results << @items.price_repo[price]
        end
        results.flatten
      end
    end

    def merchants_with_only_one_item
      @merchants.id_repo.find_all do |merchant|
        items = merchant[1].items
        items.count == 1
      end
    end

    def merchants_with_only_one_item_registered_in_month(month)
      @merchants.id_repo.find_all do |merchant|
        items = merchant[1].items
        items.count == 1 && items[0].created_at.month == month_name_to_num[month]
      end
    end
end
