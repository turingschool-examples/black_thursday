require_relative 'sales_engine'
require 'pry'

class SalesAnalyst

  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def total_item_count_per_merchant(merchant_repo)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |item_count, merchant|
      item_count + merchant.items.count
    end
  end

  def average_items_per_merchant
    merchant_repo = @engine.merchants
    merchant_count = merchant_repo.merchants.count
    total_items = total_item_count_per_merchant(merchant_repo)
    total_items.to_f / merchant_count.to_f
  end

  def sum_of_square_differences_item_count(merchant_repo, mean)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |result, merchant|
      difference_squared = (mean - merchant.items.count) ** 2
      result + difference_squared
    end
  end

  def find_sample_variance(merchant_repo, sum)
    sum / (merchant_repo.merchants.count-1)
  end

  def average_items_per_merchant_standard_deviation
    merchant_repo = @engine.merchants
    mean = average_items_per_merchant
    sum = sum_of_square_differences_item_count(merchant_repo, mean)
    sample_variance = find_sample_variance(merchant_repo, sum)
    (Math.sqrt(sample_variance)).round(2)
  end

  def merchants_with_high_item_count
    standard_deviation = average_items_per_merchant_standard_deviation
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    merchants.find_all {|merchant| merchant.items.count > standard_deviation + 1}
  end

  def average_item_price_for_merchant(merchant_id)
    item_repo = @engine.items
    items = item_repo.find_all_by_merchant_id(merchant_id)
    item_prices = items.map {|item| item.unit_price}

    if item_prices.empty?
      return 0
    else
      BigDecimal(item_prices.sum / item_prices.count).round(2)
    end
  end

  def average_average_price_per_merchant
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    merchant_averages = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    BigDecimal(merchant_averages.sum / merchant_averages.count).round(2)
  end

  def sum_of_square_differences_item_price(merchant_repo, mean)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |result, merchant|
      average_item_price = average_item_price_for_merchant(merchant.id)
      difference_squared = (mean - average_item_price) ** 2
      result + difference_squared
    end
  end

  def average_item_price_standard_deviation
    merchant_repo = @engine.merchants
    mean = average_average_price_per_merchant
    sum = sum_of_square_differences_item_price(merchant_repo, mean)
    sample_variance = find_sample_variance(merchant_repo, sum)
    (Math.sqrt(sample_variance)).round(2)
  end

  def golden_items
    standard_deviation = average_item_price_standard_deviation
    item_repo = @engine.items
    all_items = item_repo.items
    all_items.find_all {|item| item.unit_price > standard_deviation + 2}
  end

  def average_invoices_per_merchant
    invoice_count = @engine.invoices.invoices.count
    merchant_count = @engine.merchants.merchants.count

    ((invoice_count.to_f / merchant_count.to_f)).round(2)
  end

  def sum_of_square_differences_invoice_count(merchant_repo, mean)
    merchants = merchant_repo.merchants
    merchants.reduce(0) do |result, merchant|
      difference_squared = (mean - merchant.invoices.count) ** 2
      result + difference_squared
    end
  end

  def average_invoice_count_standard_deviation
    merchant_repo = @engine.merchants
    mean = average_invoices_per_merchant
    sum = sum_of_square_differences_invoice_count(merchant_repo, mean)
    sample_variance = find_sample_variance(merchant_repo, sum)
    (Math.sqrt(sample_variance)).round(2)
  end

  def top_merchants_by_invoice_count
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    standard_deviation = average_invoice_count_standard_deviation
    merchants.find_all do |merchant|
      merchant.invoices.count > standard_deviation + 2
    end
  end

  def bottom_merchants_by_invoice_count
    merchant_repo = @engine.merchants
    merchants = merchant_repo.merchants
    standard_deviation = average_invoice_count_standard_deviation
    merchants.find_all do |merchant|
      merchant.invoices.count < standard_deviation - 2
    end
  end

  def average_invoices_per_day
    invoice_repo = @engine.invoices
    invoice_count = invoice_repo.invoices.count
    (invoice_count/7.0).round(2)
  end

  def invoice_creation_days
    invoice_repo = @engine.invoices
    invoices = invoice_repo.invoices
    invoices.map do |invoice|
      date = invoice.created_at
      date.wday
    end
  end

  def invoices_created_per_day
    days = invoice_creation_days
    days_of_week = [0,1,2,3,4,5,6]
    days_of_week.map.with_index do |week_day|
      days.count {|day| day == days_of_week.index(week_day)}
    end
  end

  def sum_of_square_differences_invoices_per_day(invoices_per_day, mean)
    invoices_per_day.reduce(0) do |result, day_count|
      difference_squared = (mean - day_count) ** 2
      result + difference_squared
    end
  end

  def find_sample_variance_invoices(invoice_repo, sum)
    sum / (invoice_repo.invoices.count-1)
  end

  def invoices_per_day_standard_deviation
    invoice_repo = @engine.invoices
    mean = average_invoices_per_day
    invoices_per_day = invoices_created_per_day
    sum = sum_of_square_differences_invoices_per_day(invoices_per_day, mean)
    sample_variance = find_sample_variance_invoices(invoice_repo, sum)
    (Math.sqrt(sample_variance)).round(2)
  end


  def top_days_by_invoice_count
    week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    days = invoices_created_per_day
    standard_deviation = invoices_per_day_standard_deviation
    indices = days.map.with_index do |day, index|
      if day > standard_deviation + 1
        index
      end
    end
    indices.compact.map do |index|
      week[index]
    end

  end

  def invoice_status_count
    statuses = {:returned => 0, :pending => 0, :shipped => 0}
    invoice_repo = @engine.invoices
    invoices = invoice_repo.invoices
    invoices.each do |invoice|
      if invoice.status == "returned"
        statuses[:returned] += 1
      elsif invoice.status == "pending"
        statuses[:pending] += 1
      else
        statuses[:shipped] += 1
      end

    end
    statuses

  end


  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end

end
