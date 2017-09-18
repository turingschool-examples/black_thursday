require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'time'

class SalesAnalyst
include StandardDeviation
  attr_reader :se

  def initialize(se)
    @se = se
  end

  def average_items_per_merchant
    average = se.total_items / se.total_merchants.to_f
    average.round(2)
  end

  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation

    se.merchants.merchants.select do |merchant|
      merchant.items.count >= std_dev*2
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)

    total_item_price = merchant.items.reduce(0) do |total_price, item|
      total_price + item.unit_price
    end
    return (total_item_price /merchant.items.count).round(2) unless total_item_price == 0
    return 0
  end

  def average_average_price_per_merchant
    merchant_price_averages = se.merchants.merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    average_average = merchant_price_averages.sum / merchant_price_averages.count
    average_average.round(2)
  end

  def golden_items
    std_dev = item_standard_deviation
    se.items.items.select do |item|
      item.unit_price >  std_dev * 2
    end
  end

  def average_invoices_per_merchant
    average = se.total_invoices / se.total_merchants.to_f
    average.round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant

    difference_from_average = se.merchant_invoice_count.map do |invoice_count|
      invoice_count - average
    end
    squared_values = difference_from_average.map {|diff| diff ** 2}

    sum_of_squares = squared_values.sum

    Math.sqrt(sum_of_squares / (se.merchant_invoice_count.count - 1)).round(2)
  end

  def top_merchants_by_invoice_count
    average = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    se.merchants.merchants.select do |merchant|
      merchant.invoices.count > (average + std_dev * 2)
    end
  end

  def bottom_merchants_by_invoice_count
    average = average_invoices_per_merchant
    std_dev = average_invoices_per_merchant_standard_deviation
    se.merchants.merchants.select do |merchant|
      merchant.invoices.count < (average - std_dev * 2)
    end
  end

  def top_days_by_invoice_count
    average = average_invoices_per_day.round(2)
    invoice_count_by_day = number_of_invoices_by_day
    std_dev = daily_invoice_standard_deviation.ceil

    top_days = invoice_count_by_day.select do |day, number|
      invoice_count_by_day[day] > (average + std_dev)
    end
  end

  def number_of_invoices_by_day
    invoices_for_each_weekday = {'Monday' => 0,
                                 'Tuesday' => 0,
                                 'Wednesday' => 0,
                                 'Thursday' => 0,
                                 'Friday' => 0,
                                 'Saturday' => 0,
                                 'Sunday' => 0,
                                }

    se.invoices.invoices.each do |invoice|
      invoices_for_each_weekday[invoice.day_of_the_week] += 1
    end
    invoices_for_each_weekday
  end

  def average_invoices_per_day
    se.total_invoices.to_f / 7
  end

  def invoice_status(status)
    count = 0
    se.invoices.invoices.each {|invoice| count += 1 if invoice.status == status}
    percentage = count / se.total_invoices.to_f * 100
    percentage.round(2)
  end

  def total_revenue_by_date(date)
    count = 0.00
    se.invoices.invoices.each do |invoice|

      invoice_date = invoice.created_at.strftime('%Y-%m-%d')
      if invoice_date == date.strftime('%Y-%m-%d')

        invoice.invoice_items.each do |invoice_item|
          count += invoice_item.unit_price * invoice_item.quantity
        end
      end
    end
    count
  end

  def date_converter_to_string(date)
    split_date = date.split(' ')

    return split_date[0].to_s
  end

  def top_revenue_earners(n = 20)
    sorted_merchants = se.merchants.merchants.sort_by do |merchant|
      merchant_revenue(merchant)
    end
    top_earners = sorted_merchants.reverse[0,n]
    require "pry"; binding.pry
  end

  def merchant_revenue(merchant)
    revenue= 0.00
    merchant.invoices.each do |invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
    end
    revenue
  end

  # def merchant_revenue(merchant)
  #   revenue= 0.00
  #   merchant.items.each do |item|
  #     revenue += item.invoice_items.reduce(0) do |sum, invoice_item|
  #
  #         sum + invoice_item.unit_price * invoice_item.quantity
  #     end
  #   end
  #   revenue
  # end

end
