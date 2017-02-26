class SalesAnalyst

  attr_reader :sales_engine

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    merchant_count = sales_engine.number_of_merchants
    item_count = sales_engine.number_of_items

    (item_count / merchant_count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    items_per_merchant = sales_engine.number_of_items_per_merchant
    sum_of_means_squared = items_per_merchant.map do |number|
      (number - average_items_per_merchant)**2
    end
    Math.sqrt(sum_of_means_squared.reduce(:+) / (items_per_merchant.count - 1)).round(2)
  end

  def merchants_with_high_item_count
    total = average_items_per_merchant + average_items_per_merchant_standard_deviation
    high_sellers = []

    sales_engine.merchants.all.each do |merchant|
      if merchant.items.count >= total
        high_sellers << merchant
      end
    end
    high_sellers
  end

  def average_item_price_for_merchant(merchant_id)
    total = sales_engine.items.find_all_by_merchant_id(merchant_id)
    total_price = 0
    total.each { |item| total_price += item.unit_price }

    (total_price/total.count).round(2)
  end

  def average_average_price_per_merchant
    total = sales_engine.merchants.all.map { |merchant| merchant.id }

    total_price = 0

    total.each do |merchant_id|
      per_merchant = average_item_price_for_merchant(merchant_id)
      total_price += per_merchant
    end
      (total_price / total.count).round(2)
  end

  def average_price_standard_deviation
    all_items = sales_engine.prices_of_each_item
    average = all_items.reduce(:+).to_i/all_items.count
    sum_of_means_squared = all_items.map do |price|
      (price - average)**2
    end
  Math.sqrt(sum_of_means_squared.reduce(:+) / (all_items.count - 1)).round(2)
  end

  def golden_items
    all_items = sales_engine.prices_of_each_item
    average = all_items.reduce(:+).to_i/all_items.count

    total = average + (2 * average_price_standard_deviation)
    goldies = []

    sales_engine.items.all.each do |item|
      if item.unit_price >= total
        goldies << item
      end
    end
    goldies
  end

  def average_invoices_per_merchant
    merchant_count = sales_engine.number_of_merchants
    invoice_count = sales_engine.number_of_invoices

    (invoice_count / merchant_count.to_f).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    invoices_per_merchant = sales_engine.number_of_invoices_per_merchant
    sum_of_means_squared = invoices_per_merchant.map do |number|
      (number - average_invoices_per_merchant)**2
    end
    Math.sqrt(sum_of_means_squared.reduce(:+) / (invoices_per_merchant.count - 1)).round(2)
  end


  def top_merchants_by_invoice_count
    total = average_invoices_per_merchant + (2 * average_invoices_per_merchant_standard_deviation)
    top_merchants = []

    sales_engine.merchants.all.each do |merchant|
      if merchant.invoices.count >= total
        top_merchants << merchant
      end
    end
    top_merchants
  end


  def bottom_merchants_by_invoice_count
    total = average_invoices_per_merchant - (2 * average_invoices_per_merchant_standard_deviation)
    bottom_merchants = []

    sales_engine.merchants.all.each do |merchant|
      if merchant.invoices.count <= total
        bottom_merchants << merchant
      end
    end
    bottom_merchants
  end

  def total_days
    total = sales_engine.invoices.all.map { |invoice| invoice.created_at }
    total.map! do |date|
      date.strftime('%A')
    end
  end

  def average_invoices_per_day
   total_days.length / 7
  end

  # def average_invoices_per_day_standard_deviation
  #   days_hash = { "Sunday"=> 0, "Monday"=> 0, "Tuesday"=> 0, "Wednesday"=> 0, "Thursday"=> 0, "Friday"=> 0, "Saturday"=> 0 }
  #   counter = 0
  #   while counter < total_days.length
  #       days_hash[total_days[counter]] += 1
  #       counter += 1
  #   end
  #   require "pry"; binding.pry
  #   invoices_each_day = days_hash.values
  #   means_squared = invoices_each_day.each do |value|
  #   (value - average_invoices_per_day) ** 2
  #     end
  #   Math.sqrt(means_squared.reduce(:+) / 6).round(2)
  # end

  def invoice_status(status)
    (sales_engine.invoices.find_all_by_status(status).count * 100  / sales_engine.number_of_invoices.to_f).round(2)
  end

end
