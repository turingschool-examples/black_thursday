require_relative 'sales_engine'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    total_items = se.items.all.count
    total_merchants = se.merchants.all.count
    (total_items.to_f / total_merchants.to_f).round(2)
  end

  def average_invoices_per_merchant
    average(all_merchants_invoices).round(2)
  end

  def all_merchants_invoices
    se.merchants.all.map do |merchant|
      merchant.invoices.count
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(all_merchants_invoices)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    se.merchants.all.find_all do |merchant|
      merchant.invoices.count > average + (2 * standard_deviation)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    standard_deviation = average_invoices_per_merchant_standard_deviation
    se.merchants.all.find_all do |merchant|
      merchant.invoices.count < average - (2 * standard_deviation)
    end
  end

  def standard_deviation(numbers, average = average(numbers))
    num = numbers.map do |number|
      (number - average) ** 2
    end.sum
    Math.sqrt(num / (numbers.count - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    standard_deviation(merchant_item_count)
  end

  def merchants_with_high_item_count
    average = average_items_per_merchant
    standard_deviation = average_items_per_merchant_standard_deviation
    se.merchants.all.find_all do |merchant|
      merchant.items.count > average + standard_deviation
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)

    prices = merchant.items.map do |item|
      item.unit_price.to_f
    end
    BigDecimal(average(prices), 4)
  end

  def average_average_price_per_merchant
    average_prices = se.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    BigDecimal(average(average_prices), 6)
  end

  def golden_items
    average = average_average_price_per_merchant
    standard_deviation = standard_deviation(all_item_prices)
    se.items.all.find_all do |item|
      item.unit_price > average + (2 * standard_deviation)
    end
  end

    private

      def average(numbers)
        numbers.sum.to_f / numbers.count
      end

      def all_item_prices
        se.items.all.map do |item|
          item.unit_price
        end
      end

      def merchant_item_count
        se.merchants.all.map do |merchant|
          merchant.items.count
        end
      end

end
