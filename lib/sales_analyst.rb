require 'pry'

class SalesAnalyst
  def initialize(se)
    @se = se
  end

  def average_item_price
    set = set_of_item_prices
    sum = sum_array(set_of_item_prices)
    sum / set.count
  end

  def average_items_per_merchant
    ((@se.items.all.count.to_f) / (@se.merchants.all.count.to_f)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    set = set_of_merchant_items
    mean = set.inject(:+).to_f / set.size
    Math.sqrt(set.inject(0){|sum,val| sum + (val - mean)**2} / set.size).round(2)
  end

  def set_of_item_prices
    set = []
    @se.items.all.map do |item|
      set << item.unit_price_to_dollars
    end
    set
  end

  def set_of_merchant_items
    set = []
    @se.merchants.all.map do |merchant|
      set << merchant.items.count
    end
    set
  end

  def merchants_with_high_item_count
    @se.merchants.all.find_all do |merchant|
      merchant.items.count > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
    end
  end

  def average_item_price_for_merchant(merch_id)
    merchant = @se.merchants.find_by_id(merch_id)
    num_of_items = merchant.items.count
    if num_of_items != 0
      sum_of_prices = merchant.items.inject(0) do |sum, item|
        sum += item.unit_price_to_dollars
      end
      result = sum_of_prices/num_of_items
    else
      return nil
    end
    result.round(2)
  end

  def average_average_price_per_merchant
    all_merch_ids = @se.merchants.all.map do |merchant|
      merchant.id
    end
    total_averages = []
    all_merch_ids.each do |merch_id|
      if average_item_price_for_merchant(merch_id) != nil
        total_averages << average_item_price_for_merchant(merch_id)
      end
    end
    sum = sum_array(total_averages)
    (sum / total_averages.count).round(2)
  end

  def sum_array(array)
    sum = array.inject(0) do |sum, num|
      sum += num
    end
  end

  def average_item_price_standard_deviation
    mean = average_item_price
    set = set_of_item_prices
    Math.sqrt(set.inject(0){|sum,val| sum + (val - mean)**2} / set.size)
  end

  def golden_items
    @se.items.all.find_all do |item|
      item.unit_price_to_dollars > (average_item_price + (average_item_price_standard_deviation * 2)).round(2)
    end
  end

  def average_invoices_per_merchant
    ((@se.invoices.all.count.to_f) / (@se.merchants.all.count.to_f)).round(2)
  end

  def set_of_merchant_invoices
    set = []
    @se.merchants.all.map do |merchant|
      set << merchant.invoices.count
    end
    set
  end

  def average_invoices_per_merchant_standard_deviation
    set = set_of_merchant_invoices
    mean = set.inject(:+).to_f / set.size
    Math.sqrt(set.inject(0){|sum,val| sum + (val - mean)**2} / set.size).round(2)
  end

  def top_merchants_by_invoice_count
    @se.merchants.all.find_all do |merchant|
      merchant.invoices.count < (average_invoice_count + (average_invoices_per_merchant_standard_deviation * 2))
    end
  end

  def average_invoice_count
    set = set_of_merchant_invoices
    total_merchant_count = @se.merchants.all.count
    set.count / total_merchant_count
  end

  def bottom_merchants_by_invoice_count
    @se.merchants.all.find_all do |merchant|
      merchant.invoices.count > (average_invoice_count - (average_invoices_per_merchant_standard_deviation * 2)).round(2)
    end
  end

  def turn_date_to_day(date)
    date = Date.parse(date)
    date.strftime("%A")
  end

  def top_days_by_invoice_count
    @se.invoices.all.find_all do |invoice|
    end
  end

end
