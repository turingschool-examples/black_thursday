require_relative 'sales_engine'
require_relative 'standard_deviation'
require 'time'
require 'bigdecimal'

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
    top_days.keys
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
    grouped_invoices = paid_invoices.group_by do |invoice|
      invoice.merchant_id
    end

    grouped_invoices.each_value do |invoice|
      invoice.map! {|invoice| invoice.total}
    end

    merchant_totals = grouped_invoices.keys.sort_by do |merchant_id|
      grouped_invoices[merchant_id].reduce(:+)
    end

    top_merchants = merchant_totals.map do |merch|
      se.merchants.find_by_id(merch)
    end

    return top_merchants.reverse[0..n-1]

    # sorted_merchants = se.merchants.merchants.sort_by do |merchant|
    #   merchant_revenue(merchant)
    # end
    # top_earners = sorted_merchants.reverse[0,n]
  end

  def merchant_revenue(merchant)
    revenue= 0.00
    merchant.invoices.each do |invoice|
      revenue += invoice.total if invoice.is_paid_in_full?
    end
    revenue
  end

  def merchants_with_pending_invoices
    se.merchants.all.select do |merchant|
      merchant.invoices.any? do |invoice|
        invoice.transactions.all? do |transaction|
          transaction.result == 'failed'
        end
      end
    end
  end


  def paid_invoices
    se.invoices.all.select {|invoice| invoice.is_paid_in_full?}
  end


  # def merchants_with_only_one_item_registered_in_month(month_name)
  #   merchant_by_month = merchant_by_month_created
  #   #for each merchant, group their invoices by month created
  #   merchants = merchant_by_month[month_name]
  #   one_item_merchants = merchants.select do |merchant|
  #     #what sort of truth condition are we going to get here?
  #     items_by_month = merchant.items.group_by do |item|
  #       item.updated_at.strftime('%B')
  #     end
  #     if items_by_month[month_name].nil?
  #       false
  #     else
  #       items_by_month[month_name].count == 1
  #     end
  #
  #   end
  #   one_item_merchants
  # end



  # def merchants_with_only_one_item_registered_in_month(month_name)
  #   merchant_by_month = merchant_by_month_created
  #   one_item_merchants = merchant_by_month[month_name].select do |merchant|
  #       item_in_month?(merchant, month_name)
  #   end
  #   one_item_merchants
  # end

  def merchants_with_only_one_item_registered_in_month(month_name)
    one_item_merchants_by_month = merchants_with_only_one_item.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
    one_item_merchants_by_month[month_name]
  end



  def item_in_month?(merchant, month_name)
    items_in_month = merchant.items.select do |item|
      item.created_at.strftime('%B') == month_name
    end
    items_in_month.length == 1
  end

  def merchant_by_month_created
    se.merchants.all.group_by do |merchant|
      merchant.created_at.strftime('%B')
    end
  end

  def item_by_month_created
    se.items.all.group_by do |item|
      item.created_at.strftime('%B')
    end
  end



  # def revenue_by_merchant(merchant_id)
  #   revenue= 0.00
  #   merchant = se.merchants.find_by_id(merchant_id)
  #   merchant.invoices.each do |invoice|
  #     revenue += invoice.total if invoice.is_paid_in_full?
  #   end
  #   revenue
  # end


  def merchants_with_only_one_item
    se.merchants.all.select do |merchant|
      merchant.items.count == 1
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    revenue = merchant_revenue(merchant)
    BigDecimal.new(revenue, 4)
  end

  def total_sold_for_item(item)
    item.invoice_items.reduce(0) do |total_sold, invoice_item|
      total_sold + invoice_item.quantity
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    items = merchant.items

    items_by_total_sold = items.group_by do |item|
      total_sold_for_item(item)
    end
    max_sold = items_by_total_sold.keys.max
    items_by_total_sold[max_sold]
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
