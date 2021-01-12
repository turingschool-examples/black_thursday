class SalesAnalyst
  attr_reader :parent

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    (all_items_count / all_merchants_count.to_f).round(2)
  end

  def all_items_count
    @parent.items.all.length
  end

  def all_merchants_count
    @parent.merchants.all.length
  end

  def generate_merchant_ids
    @parent.merchants.all.map do |merchant|
      merchant.id
    end
  end

  def items_count_per_merchant
    generate_merchant_ids.map do |id|
      @parent.items.find_all_by_merchant_id(id).count
    end
  end

  def all_elements_minus_one(collection)
    collection.length - 1
  end

  def standard_deviaton_calculation(total, collection_minus_one)
    standard_deviaton = Math.sqrt(total / collection_minus_one)
    standard_deviaton.round(2)
  end

  def total(set_collection, average_collection)
    set_collection.reduce(0) do |total, element|
      total += ((element - average_collection) ** 2)
    end
  end

  def average_items_per_merchant_standard_deviation
    standard_deviaton_calculation(total(items_count_per_merchant, average_items_per_merchant), all_elements_minus_one(items_count_per_merchant))
  end

  def merchants_with_high_item_count
    high_seller_count = average_items_per_merchant + average_items_per_merchant_standard_deviation
    merchants = []
    generate_merchant_ids.find_all do |id|
      item_count = @parent.items.find_all_by_merchant_id(id).count
      merchants.push(@parent.merchants.find_by_id(id)) if item_count > high_seller_count
    end
    merchants
  end

  def average_item_price_for_merchant(id)
    item_count = @parent.items.find_all_by_merchant_id(id).count
    all_items_price = @parent.items.find_all_by_merchant_id(id).sum do |item|
      item.unit_price
    end
    average_price = all_items_price / item_count.to_f
    average_price.round(2)
  end

  def average_average_price_per_merchant
    all_merchants_price_averages = generate_merchant_ids.sum do |id|
      average_item_price_for_merchant(id)
    end
    all_merchants_average = (all_merchants_price_averages / all_merchants_count).round(2)
  end

  def mean_prices_per_merchant
    mean_prices_per_merchant = generate_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end
  end

  def golden_items
    mean_average_across_all_merchants = average_average_price_per_merchant
    two_standard_deviations_plus_average = (average_average_price_per_merchant * 3) + standard_deviaton_calculation(total(mean_prices_per_merchant, mean_average_across_all_merchants), all_elements_minus_one(mean_prices_per_merchant))
    expensive_items = @parent.items.all.find_all do |item|
      item.unit_price > two_standard_deviations_plus_average
    end
    expensive_items
  end


#   sales_analyst.invoice_paid_in_full?(invoice_id) returns true if the Invoice with the corresponding id is paid in full
# sales_analyst.invoice_total(invoice_id) returns the total $ amount of the Invoice with the corresponding id.
end
