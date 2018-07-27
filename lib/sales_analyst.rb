require_relative './sales_engine'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchants_total = find_number_of_merchants
    items_total = find_total_number_of_items
    (items_total.to_f / merchants_total).round(2)
  end

  def average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    ipm = items_per_merchant
    v = variance(average, ipm)
    square_root_of_variance(v, ipm)
  end

  def group_items_by_merchant
    @sales_engine.items.all.group_by(&:merchant_id)
  end

  def find_number_of_merchants
    group_items_by_merchant.inject(0) do |count, (id, items)|
      count + 1
    end
  end

  def find_total_number_of_items
    group_items_by_merchant.inject(0) do |count, (id, items)|
      count + items.count
    end
  end

  def items_per_merchant
    group_items_by_merchant.map do |id, items|
      items.count
    end
  end

  def variance(average, array)
    #need to update this name to show it's for item quantity
    array.inject(0) do |count, items|
      count += (items - average) ** 2
    end
  end

  def square_root_of_variance(variance, array)
    (Math.sqrt(variance/(array.size-1))).round(2)
  end

  def items_one_standard_deviation_above
    #item quantity
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def merchants_with_high_item_count
    item_amount_per_merchant.map do |id, quantity|
      @sales_engine.merchants.find_by_id(id) if quantity >= items_one_standard_deviation_above
    end.compact
  end

  def item_amount_per_merchant
    group_items_by_merchant.keys.zip(items_per_merchant)
  end

  def number_of_merchants
    @sales_engine.merchants.all.count
  end

  def average_item_price_for_merchant(merchant_id)
    items = @sales_engine.items.find_all_by_merchant_id(merchant_id)
    sum = items.inject(0) do |total, item|
      total + item.unit_price
    end
    (sum / items.count).round(2)
  end

  def average_average_price_per_merchant
    sum = @sales_engine.merchants.all.inject(0) do |total, merchant|
      total + average_item_price_for_merchant(merchant.id)
    end
    (sum / number_of_merchants).round(2)
  end

  def average_item_prices_for_each_merchant
    @sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def all_item_prices_total
    @sales_engine.items.all.inject(0) do |total, item|
      total + item.unit_price
    end
  end

  def item_price_average
    (all_item_prices_total / @sales_engine.items.all.count).round(2)
  end

  def all_item_prices
    @sales_engine.items.all.map do |item|
      item.unit_price
    end
  end

  def standard_deviation_for_item_price
    v = variance(item_price_average, all_item_prices)
    square_root_of_variance(v, all_item_prices)
  end

  def two_standard_deviations_above
    item_price_average + (standard_deviation_for_item_price * 2)
  end

  def golden_items
    @sales_engine.items.all.each_with_object([]) do |item, collection|
      collection << item if item.unit_price >= two_standard_deviations_above
      collection
    end
  end


#---------------ITERATION-2-STUFF------------------------#
# sales_analyst.average_invoices_per_merchant # => 10.49
  # def average_invoices_per_merchant
  #   grouped_invoices = group_invoices_by_merchant
  #   merchants_total = find_number_of_merchants(grouped_invoices)
  #   invoices_total = find_total_number_of_invoices(grouped_invoices)
  #   (invoices_total.to_f / merchants_total).round(2)
  # end
# sales_analyst.average_invoices_per_merchant_standard_deviation # => 3.29
  # def average_invoices_per_merchant_standard_deviation
  #   average = average_invoices_per_merchant
  #   grouped_invoices = group_invoices_by_merchant
  #   ipm = invoices_per_merchant(grouped_invoices)
  #   v = variance(average, ipm)
  #   square_root_of_variance(v, ipm)
  # end
  #
  # def group_invoices_by_merchant
  #   @sales_engine.invoices.all.group_by(&:merchant_id)
  # end
  #
  # def find_number_of_merchants(grouped_invoices)
  #   grouped_invoices.inject(0) do |count, (id, invoices)|
  #     count + 1
  #   end
  # end
  #
  # def find_total_number_of_invoices(grouped_invoices)
  #   grouped_invoices.inject(0) do |count, (id, invoices)|
  #     count + invoices.count
  #   end
  # end
  #
  # def invoices_per_merchant(grouped_invoices)
  #   grouped_invoices.map do |id, invoices|
  #     invoices.count
  #   end
  # end

# Which merchants are more than two standard deviations above the mean?
# sales_analyst.top_merchants_by_invoice_count # => [merchant, merchant, merchant]
  # def two_standard_deviations_above
  #   average_invoices_per_merchant + average_invoices_per_merchant_standard_deviation*2
  # end
  #
  # def top_merchants_by_invoice_count
  #   group_invoices_by_merchant.find_all do |id, invoices|
  #     invoices.count > two_standard_deviations_above
  #   end
  # end
# sales_analyst.bottom_merchants_by_invoice_count # => [merchant, merchant, merchant]
#   def two_standard_deviations_below
#     average_invoices_per_merchant - average_invoices_per_merchant_standard_deviation*2
#   end
#
#   def bottom_merchants_by_invoice_count
#     group_invoices_by_merchant.find_all do |id, invoices|
#       invoices.count < two_standard_deviations_below
#     end
#   end
end
