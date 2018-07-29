require 'bigdecimal'

class SalesAnalyst

  def initialize(merchant_repository,
                 item_repository,
                 invoice_repository,
                 transaction_repository,
                 invoice_item_repository)
    @merchant_repository      = merchant_repository
    @item_repository          = item_repository
    @invoice_repository       = invoice_repository
    @transaction_repository   = transaction_repository
    @invoice_item_repository  = invoice_item_repository
  end

  def average_items_per_merchant
    @item_repository.average_items_per_merchant
  end

  def average_invoices_per_merchant
    @invoice_repository.average_invoices_per_merchant
  end

  def average_items_per_merchant_standard_deviation
    mean_total_sqr = @item_repository.group_item_by_merchant_id
    mean_items_per = average_items_per_merchant

    (Math.sqrt(get_mean_of_totaled_squares(mean_total_sqr, mean_items_per))).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    mean_total_sqr = @invoice_repository.group_invoices_by_merchant_id
    mean_items_per = average_invoices_per_merchant

    (Math.sqrt(get_mean_of_totaled_squares(mean_total_sqr, mean_items_per))).round(2)
  end

  def average_invoices_per_day_standard_deviation
    mean_total_sqr = @invoice_repository.group_by_day
    mean_items_per = @invoice_repository.average_invoices_per_day

    (Math.sqrt(get_mean_of_totaled_squares(mean_total_sqr, mean_items_per))).round(2)
  end


  def get_squared_item_prices
    @item_repository.items.map do |item|
      (item.unit_price - @item_repository.mean_item_price) ** 2
    end
  end

  def get_mean_of_items_squared
    sum = get_squared_item_prices.inject(0) do |total, price|
      total += price
    end
    sum / get_squared_item_prices.count
  end

  def average_price_per_item_standard_deviation
    (Math.sqrt( get_mean_of_items_squared )).round(2)
  end

  def golden_items
    mean  = @item_repository.mean_item_price
    stdev = average_price_per_item_standard_deviation * 2
    @item_repository.items.find_all do |item|
      item.unit_price > (mean + stdev)
    end
  end

  def top_merchants_by_invoice_count
    mean  = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation * 2
    thing = @invoice_repository.group_invoices_by_merchant_id.find_all do |merchant, invoices|
      invoices.size > (mean + stdev)
    end
    thing.map! do |array|
      array[0]
    end
    new_thing = thing.map do |id|
      @merchant_repository.find_by_id(id)
    end
    new_thing
  end

  def bottom_merchants_by_invoice_count
    mean  = average_invoices_per_merchant
    stdev = average_invoices_per_merchant_standard_deviation * 2
    thing = @invoice_repository.group_invoices_by_merchant_id.find_all do |merchant, invoices|
      invoices.size < (mean - stdev)
    end
    thing.map! do |array|
      array[0]
    end
    new_thing = thing.map do |id|
      @merchant_repository.find_by_id(id)
    end
    new_thing
  end

  def merchants_with_high_item_count
    stdev   = average_items_per_merchant_standard_deviation
    average = average_items_per_merchant
    hash    = @item_repository.group_item_by_merchant_id
    array   = []
    hash.each do |id, items|
      if items.count > (stdev + average)
        array << @merchant_repository.find_by_id(id)
      end
    end
    array
  end

  def average_item_price_for_merchant(id)
    @item_repository.average_item_price_for_merchant(id)
  end

  def average_average_price_per_merchant
    @item_repository.average_average_price_per_merchant
  end

  def get_mean_of_totaled_squares(grouped_hash, average)
    get_total_of_squares(grouped_hash, average) / get_squared_values(grouped_hash, average).count
  end

  def get_total_of_squares(grouped_hash, average)
    get_squared_values(grouped_hash, average).inject(0) { |sum, value| sum += value}
  end

  def get_squared_values(grouped_hash, average)
    grouped_hash.map do |id, item|
      (item.count - average) ** 2
    end
  end

  # Probably a better way to write this
  def invoice_paid_in_full?(invoice_id)
    invoices = @transaction_repository.find_all_by_invoice_id(invoice_id)
    if invoices.empty?
      false
    else
      invoices.all? do |invoice|
        invoice.result == :success
      end
    end
  end

  def invoice_total(invoice_id)
    invoices = @invoice_item_repository.find_all_by_invoice_id(invoice_id)
    invoices.inject(0) do |sum, invoice|
      sum + invoice.unit_price * invoice.quantity.to_i
    end
  end

  def count_per_day
    @invoice_repository.group_by_day.map { |day, invoices| invoices.count }
  end

  def average_number_of_invoices_created_per_day
    (count_per_day.inject(0, &:+).to_f / 7).round(2)
  end

  def invoice_per_day_standard_deviation
    average = average_number_of_invoices_created_per_day
    abs_differences = count_per_day.map do |count|
      ((count - average).abs) ** 2.0
    end
    total = abs_differences.inject(0, &:+)
    (Math.sqrt(total / 6)).round(2)
  end

  def top_days_by_invoice_count
    st_dev = average_number_of_invoices_created_per_day + invoice_per_day_standard_deviation
    day_counts = @invoice_repository.group_by_day
    day_counts.select { |_day, invoices | invoices.size > st_dev }.keys
  end

  def invoice_status(status)
    @invoice_repository.invoice_status(status)
  end
end
