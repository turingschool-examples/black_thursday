require_relative '../lib/sales_engine'
require 'pry'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
    @invoices = sales_engine.invoices
  end

  def total_items
    @items.id_repo.count.to_f
  end

  def total_merchants
    @merchants.id_repo.count.to_f
  end

  def total_invoices
    @invoices.id_repo.count.to_f
  end

  def total_of_all_prices
    @items.price_repo.keys.reduce(0) do |price_sum, price|
      @items.find_all_by_price(price).count.times do
        price_sum += price
      end
      price_sum
    end
  end

  def convert_date_to_day(time_object)
    if time_object.monday?
      :Monday
    elsif time_object.tuesday?
      :Tuesday
    elsif time_object.wednesday?
      :Wednesday
    elsif time_object.thursday?
      :Thursday
    elsif time_object.friday?
      :Friday
    elsif time_object.saturday?
      :Saturday
    else
      :Sunday
    end
  end

  def invoices_by_day
    @invoices.id_repo.values.reduce({:Monday => [],
                                     :Tuesday => [],
                                     :Wednesday => [],
                                     :Thursday => [],
                                     :Friday => [],
                                     :Saturday => [],
                                     :Sunday =>[]}) do |result_hash, invoice_object|
      object_day = convert_date_to_day(invoice_object.created_at)
      result_hash[object_day] << invoice_object
      result_hash
    end
  end

  def average_invoices_per_day
    (total_invoices / 7.0).round(2)
  end

  def average_items_per_merchant
    (total_items / total_merchants).round(2)
  end

  def average_price_per_merchant
    (total_of_all_prices / total_merchants).round(2)
  end

  def average_item_price
    (total_of_all_prices / total_items).round(2)
  end

  def average_invoices_per_merchant
    (total_invoices / total_merchants).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    if !(merchant.nil?)
      total = merchant.items.reduce(0) do |total_price, item|
        total_price += item.unit_price
        total_price
      end
      average = (total / merchant.items.count).round(2)
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

  def average_items_per_merchant_standard_deviation
    count_items = Proc.new {|merchant| merchant.items.count}
    standard_deviation(average_items_per_merchant, @merchants.id_repo, count_items, total_merchants)
  end

  def item_price_standard_deviation
    item_price = Proc.new {|item| item.unit_price}
    standard_deviation(average_item_price, @items.id_repo, item_price, total_items)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoices = Proc.new {|merchant| merchant.invoices.count}
    standard_deviation(average_invoices_per_merchant, @merchants.id_repo, merchant_invoices, total_merchants)
  end

  def average_invoices_per_day_standard_deviation
    summed = invoices_by_day.keys.reduce(0) do |sum, day|
      invoices_on_this_day = invoices_by_day[day].count
      sum += (invoices_on_this_day - average_invoices_per_day) ** 2
      sum
    end
    divided_result = summed / (total_invoices - 1)
    Math.sqrt(divided_result).round(2)
  end

  def merchants_with_high_item_count
    standard_dev = average_items_per_merchant_standard_deviation
    @merchants.id_repo.keys.reduce([]) do |results, id|
      merchant = @merchants.find_by_id(id)
      if merchant.items.count > average_items_per_merchant + standard_dev
        results << merchant
      end
      results
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

  def top_merchants_by_invoice_count
    two_stndv_above_avg = (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
    @merchants.id_repo.keys.reduce([]) do |results, id|
      if @merchants.id_repo[id].invoices.count >= two_stndv_above_avg
        results << @merchants.id_repo[id]
      end
      results.flatten
    end
  end

  def bottom_merchants_by_invoice_count
    two_stndv_below_avg = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    @merchants.id_repo.keys.reduce([]) do |results, id|
      if @merchants.id_repo[id].invoices.count <= two_stndv_below_avg
        results << @merchants.id_repo[id]
      end
      results.flatten
    end
  end

  def top_days_by_invoice_count
    two_stndv_above_avg = average_invoices_per_day_standard_deviation + average_invoices_per_day
    invoices_by_day.keys.reduce([]) do |results, day|
      if invoices_by_day[day].count >= two_stndv_above_avg
        results << day
      end
      results
    end
  end

  def invoice_status(symbol_marker)
    look_for = symbol_marker.to_s
    number_of = @invoices.id_repo.values.reduce(0) do |number, invoice|
      if invoice.status == look_for
        number += 1
      end
      number.to_f
    end
    ((number_of / total_invoices) * 100).round(2)
  end
######################################################################################
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

  def total_revenue_by_date(date)
    relevant_items = @transactions.id_repo.values.reduce([]) do |result, transaction|
      if transaction.created_at == date
        if transaction.result == :success
          invoice = transaction.invoice
          result << invoice.items
        end
      end
      result.flatten
    end
    relevant_items.reduce(0) do |total, item|
      total += (item.unit_price * item.quantity)
      total
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    return merchant.invoices.reduce(0) do |total, invoice|
      merchant_invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
      total += merchant_invoice_items.reduce(0) do |item_total, item|
        item_total += item.quantity * item.unit_price
        item_total
      end
      total
    end
  end

  def top_revenue_earners(number=20)
    top_earners = []
    number.times do
      top_earner = ""
      @merchants.id_repo.keys.reduce(0) do |max_revenue, id|
        revenue = revenue_by_merchant(id)
        if revenue >= max_revenue && !(top_earners.include?(@merchants.id_repo[id]))
          max_revenue = revenue
          top_earner = @merchants.id_repo[id]
        end
      end
      top_earners << top_earner
    end
    top_earners.compact
  end

  def merchants_with_pending_invoices
    @merchants.id_repo.find_all do |merchant|
      invoices = merchant[1].invoices
      invoices.any? do |invoice|
        invoice.status == pending
      end
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

  def enumerate_item_invoices(item, attribute_proc)
    item_invoices = @invoice_items.find_all_by_item_id(item.id)
    if !(item_invoices.empty?)
      value = item_invoices.reduce(0) do |passed_value, invoice_item|
        passed_value += attribut_proc.call(invoice_item)
      end
    else
      return 0
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    max_count = 0
    high_item = merchant.items.reduce([]) do |high_item, item|
      count = enumerate_item_invoices(item, Proc.new {|invoice_item| invoice_item.quantity})
      if count > max_count
        max_count = count
        high_item = [item]
      elsif count == max_count
        high_item << item
      end
    end
    high_item
  end

  def best_item_for_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    max_revenue = 0
    high_item = merchant.items.reduce([]) do |high_item, item|
      revenue = enumerate_item_invoices(item, Proc.new {|invoice_item| invoice_item.quantity * invoice_item.unit_price})
      if revenue >= max_revenue
        max_revenue = revenue
        high_item = item
      end
    end
    high_item
  end

end
