class SalesAnalyst
  attr_reader :parent

  def initialize(parent)
    @parent = parent
  end

  def average_items_per_merchant
    (all_collection_count(@parent.items) / all_collection_count(@parent.merchants).to_f).round(2)
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
    all_merchants_average = (all_merchants_price_averages / all_collection_count(@parent.merchants)).round(2)
  end

  def mean_prices_per_merchant
    mean_prices_per_merchant = generate_merchant_ids.map do |id|
      average_item_price_for_merchant(id)
    end
  end

  def golden_items
    mean_average_across_all_merchants = average_average_price_per_merchant
    two_standard_deviations_above_average = (average_average_price_per_merchant * 3) + standard_deviaton_calculation(total(mean_prices_per_merchant, mean_average_across_all_merchants), all_elements_minus_one(mean_prices_per_merchant))
    expensive_items = @parent.items.all.find_all do |item|
      item.unit_price > two_standard_deviations_above_average
    end
    expensive_items
  end

  def all_collection_count(collection)
    collection.all.length
  end

  def average_invoices_per_merchant
    (all_collection_count(@parent.invoices) / all_collection_count(@parent.merchants).to_f).round(2)
  end

  def invoice_count_per_merchant
    generate_merchant_ids.map do |id|
      @parent.invoices.find_all_by_merchant_id(id).count
    end
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviaton_calculation(total(invoice_count_per_merchant, average_invoices_per_merchant), all_elements_minus_one(invoice_count_per_merchant))
  end

  def average_invoices_per_day_standard_deviation
    standard_deviaton_calculation(total(invoices_count_per_day, average_invoices_per_day), all_elements_minus_one(invoices_by_days.values))
  end

  def average_invoices_per_day
    (all_collection_count(@parent.invoices) / 7.0).round(2)
  end

  def invoices_count_per_day
    invoices_by_days.map do |day, invoices|
      invoices.length
    end
  end

  def invoices_by_merchant_id
    @parent.invoices.all.group_by do |id|
      id.merchant_id
    end
  end

  def invoices_by_days
    @parent.invoices.all.group_by do |invoice|
      if invoice.created_at.wday == 1
        "Monday"
      elsif invoice.created_at.wday == 2
        "Tuesday"
      elsif invoice.created_at.wday == 3
        "Wednesday"
      elsif invoice.created_at.wday == 4
        "Thursday"
      elsif invoice.created_at.wday == 5
        "Friday"
      elsif invoice.created_at.wday == 6
        "Saturday"
      elsif invoice.created_at.wday == 0
        "Sunday"
      end
    end
  end

  def top_merchants_by_invoice_count
    mean_average_across_all_merchants = average_invoices_per_merchant
    two_standard_deviations_plus_average = (average_invoices_per_merchant_standard_deviation * 2) + mean_average_across_all_merchants
    top_merchants = []
    generate_merchant_ids.each do |id|
      if invoices_by_merchant_id[id].length > two_standard_deviations_plus_average
        top_merchants << @parent.merchants.find_by_id(id)
      end
    end
    top_merchants
  end

  def bottom_merchants_by_invoice_count
    mean_average_across_all_merchants = average_invoices_per_merchant
    two_standard_deviations_below_average = mean_average_across_all_merchants - (average_invoices_per_merchant_standard_deviation * 2)
    bottom_merchants = []
    generate_merchant_ids.each do |id|
      if invoices_by_merchant_id[id].length < two_standard_deviations_below_average
        bottom_merchants << @parent.merchants.find_by_id(id)
      end
    end
    bottom_merchants
  end

  def top_days_by_invoice_count
    one_standard_deviation_plus_average = average_invoices_per_day_standard_deviation + average_invoices_per_day
    top_days = []
    invoices_by_days.each do |day, invoices|
      top_days << day if invoices.length > one_standard_deviation_plus_average
    end
    top_days
  end

  def invoice_status_collection(status)
    @parent.invoices.find_all_by_status(status).length
  end

  def invoice_status(status)
    ((invoice_status_collection(status) / all_collection_count(@parent.invoices).to_f) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    invoice = parent.invoices.find_by_id(invoice_id)
    #i think i'm having trouble unstanding what makes it paid in full or successful
    #An invoice is considered paid in full if it has a successful transaction
    # with invoice_id we would find the transaction
    #use find_by_id to get the invoice object
    #check to see if the transaction.result == "success"

  end


  def invoice_total(invoice_id)
    #quantity * item.price && transaction == "success"
    #Failed charges should never be counted in revenue totals or statistics.
  end
end
