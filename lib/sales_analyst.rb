require_relative 'sales_engine'
require_relative 'time_calculation'
require_relative 'math_calculation'
require 'bigdecimal'
require 'pry'

class SalesAnalyst
  include TimeCalculation
  include MathCalculation

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

  def days_invoice_created
    se.invoices.all.group_by do |invoice|
      day_of_the_week(invoice.created_at)
    end
  end

  def days_with_number_of_invoices
    days_invoice_created.transform_values do |invoices|
      invoices.count
    end
  end

  def average_invoices_per_day
    average(days_with_number_of_invoices.values)
  end

  def standard_deviation_invoices_per_day
    standard_deviation(days_with_number_of_invoices.values)
  end

  def top_days_by_invoice_count
    top_days = []
    average = average_invoices_per_day
    standard_deviation = standard_deviation_invoices_per_day
    days_with_number_of_invoices.each do |day, invoices|
      if invoices > average + standard_deviation
        top_days << day
      end
    end
    top_days
  end

  def total_number_of_invoices
    se.invoices.all.count
  end

  def number_of_invoices_with_status(status)
    se.invoices.find_all_by_status(status.to_s).count.to_f
  end

  def invoice_status(status)
    total = total_number_of_invoices
    (number_of_invoices_with_status(status) / total * 100).round(2)
  end

  def top_buyers(number_of_buyers = 20)
    customers_with_total = Hash.new(0)

    se.invoices.all.each do |invoice|
      customers_with_total[invoice.customer] += invoice.total
    end

    sorted_customers = customers_with_total.sort_by do |customer, total|
      total
    end.reverse

    top_spenders = sorted_customers.take(number_of_buyers)

    top_spenders.map do |customer|
      customer[0]
    end
  end

  def top_merchant_for_customer(customer_id)
    all_invoices = se.invoices.find_all_by_customer_id(customer_id)

    hash = Hash.new(0)

    all_invoices.each do |invoice|
      hash[invoice.merchant] = quantity(invoice.invoice_items)
    end

    hash.max_by{|merchant, item_count| item_count}.first
  end

  def quantity(invoice_items)
    invoice_items.map do |invoice_item|
      invoice_item.quantity
    end.sum
  end

  def one_time_buyers
    specific_customers = Hash.new(0)

    se.customers.all.each do |customer|
      specific_customers[customer] = customer.fully_paid_invoices.count
    end

    one_time_customers = specific_customers.find_all do |cust, paid_invoices|
      paid_invoices == 1
    end

    one_time_customers.map do |customer, paid_invoices|
      customer
    end
  end

  def one_time_buyers_top_items
    all_invoices = one_time_buyers.map do |customer|
      customer.fully_paid_invoices
    end.flatten

    all_invoice_items = all_invoices.map do |invoice|
      invoice.invoice_items
    end.flatten

    items_with_quantity = Hash.new(0)

    all_invoice_items.each do |invoice_item|
      if items_with_quantity[invoice_item.item_id]
        items_with_quantity[invoice_item.item_id] += invoice_item.quantity
      else
        items_with_quantity[invoice_item.item_id] = invoice_item.quantity
      end
    end

    top_item_ID = items_with_quantity.max_by do |item, quantity|
      quantity
    end

    Array.new << se.items.find_by_id(top_item_ID[0])
  end

    private

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
