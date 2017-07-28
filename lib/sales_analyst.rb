require_relative '../lib/sales_engine'

class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
    @merchants = sales_engine.merchants
    @items = sales_engine.items
  end

  def total_items
    @items.id_repo.count.to_f
  end

  def total_merchants
    @mercants.id_repo.count.to_f
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
      total = merchant_items.reduce(0) do |total_price, item|
        total_price += item.unit_price
        total_price
      end
      average = (total / merchant.items.count).round(2)
    end
  end

  def standard_deviation(average, numerator_repo, numerator_attribute_proc, total)
    summed = numerator_repo.reduce(0) do |sum, identifier|
      object = numerator_repo[identifier]
      attribute_value = numerator_attribute_proc.call(object)
      sum += (attribute_value - average) ** 2
      sum
    end
    divided_result = sum / (total - 1)
    Math.sqrt(divided_result).round(2)
  end

  def average_items_per_merchant_standard_deviation
    count_items = Proc.new {|merchant| merchant.items.count}
    standard_deviation(average_items_per_merchant, @merchant.id_repo, count_items, total_merchants)
  end

  def item_price_standard_deviation
    item_price = Proc.new {|item| item.unit_price}
    standard_deviation(average_item_price, @items.id_repo, item_price, total_items)
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoices = Proc.new {|merchant| merchant.invoices.count}
    standard_deviation(average_invoices_per_merchant, @merchants.id_repo, merchant_invoices, total_merchants)
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


end
