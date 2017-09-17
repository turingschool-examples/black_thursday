
class SalesAnalyst

  def initialize(engine)
    @engine = engine
    @days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  end

  def average_items_per_merchant
    (@engine.items.all.count.to_f / @engine.merchants.all.count.to_f).round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_counts = get_item_count_from_merchants
    squared = square_counts(item_counts)
    sum = squared.inject(:+)
    divided = sum / (@engine.merchants.all.count - 1)
    Math.sqrt(divided).round(2)
  end

  def get_item_count_from_merchants
    @engine.merchants.all.map do |merchant|
      merchant.items.count
    end
  end

  def square_counts(item_counts)
    squared = item_counts.map do |count|
      (count - average_items_per_merchant) ** 2
    end
  end

  def merchants_with_high_item_count
    bar = average_items_per_merchant + average_items_per_merchant_standard_deviation
    @engine.merchants.all.find_all do |merchant|
      merchant.items.count > bar
    end
  end

  def average_item_price_for_merchant(merchant_id)
    merchant = @engine.merchants.find_by_id(merchant_id)
    sum = merchant.items.inject(0) do |total, item|
      total += item.unit_price/100
    end
    (sum / merchant.items.count * 100).round(2)
  end

  def average_average_price_per_merchant
    average_prices = @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    (average_prices.reduce(:+) / @engine.merchants.all.count).truncate(2)
  end

  def average_item_price
    prices = @engine.items.items.map do |item|
      item.unit_price
    end
    prices.inject(:+) / @engine.items.items.count
  end

  def item_price_standard_deviation
    squared = @engine.items.items.map do |item|
      (item.unit_price - average_item_price) ** 2
    end
    divided = squared.inject(:+) / (@engine.items.items.count - 1)
    Math.sqrt(divided)
    # TODO this is where it converts check decimal count
  end

  def golden_items
    bar = (2 * item_price_standard_deviation) + average_item_price
    @engine.items.items.find_all do |item|
      item.unit_price > bar
    end
  end
  #
  def average_invoices_per_merchant
    @engine.invoices.all.count.to_f / @engine.merchants.all.count.to_f
  end

  def average_invoices_per_merchant_standard_deviation
    squared  = @engine.merchants.all.map do |merchant|
      (merchant.invoices.count - average_invoices_per_merchant) ** 2
    end
    divided = squared.inject(:+) / (@engine.merchants.merchants.count - 1)
    Math.sqrt(divided)
  end

  def top_merchants_by_invoice_count
    bar = (2 * average_invoices_per_merchant_standard_deviation) + average_invoices_per_merchant
    @engine.merchants.merchants.find_all do |merchant|
      merchant.invoices.count > bar
    end
  end

  def bottom_merchants_by_invoice_count
    bar = average_invoices_per_merchant - (2 * average_invoices_per_merchant_standard_deviation)
    @engine.merchants.merchants.find_all do |merchant|
      merchant.invoices.count < bar
    end
  end

  def average_invoices_created_per_day
    @engine.invoices.invoices.count / 7
  end

  def number_of_invoices_created_per_day
    @days.map do |day|
      @engine.invoices.invoices.find_all do |invoice|
        invoice.created_day == day
      end.count
    end
  end

  def number_of_invoices_created_per_day_standard_deviation
    squared = number_of_invoices_created_per_day.map do |day|
      (day - average_invoices_created_per_day) ** 2
    end
    divided = squared.inject(:+).to_f / 6
    Math.sqrt(divided)
  end

  def top_days_by_invoice_count
    days = []
    bar = average_invoices_created_per_day + number_of_invoices_created_per_day_standard_deviation
    number_of_invoices_created_per_day.each.with_index do |invoice_count, index|
      if invoice_count > bar
        days << index
      end
    end
    translate_days(days)
  end

  def translate_days(array)
    array.map do |value|
      if value == 0
        "Sunday"
      elsif value == 1
        "Monday"
      elsif value == 2
        "Tuesday"
      elsif value == 3
        "Wednesday"
      elsif value == 4
        "Thursday"
      elsif value == 5
        "Friday"
      elsif value == 6
        "Saturday"
      end
    end
  end

  def total_invoices_count
    @engine.invoices.invoices.count
  end

  def invoice_status(status)
    count = 0
    @engine.invoices.invoices.each do |invoice|
      if invoice.status == status
        count += 1
      end
    end
    (count / total_invoices_count.to_f)
  end
end
