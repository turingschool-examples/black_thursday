require_relative './statistics'

class SalesAnalyst
  include Statistics

  def initialize(input)
    @merchants = input[:merchants]
    @items = input[:items]
    @invoices = input[:invoices]
    @transactions = input[:transactions]
    @invoice_items = input[:invoice_items]
  end

  def average_items_per_merchant
    items_by_merchant = @items.all.group_by { |item| item.merchant_id }
    item_count = items_by_merchant.inject(0) { |sum, n| n[1].count + sum }
    (item_count.to_f / items_by_merchant.count).round(2)
  end

  def average_price_of_items
    tot_of_all_prices = @items.all.inject(0) do |sum, item|
      sum + item.unit_price_to_dollars
    end
    (tot_of_all_prices / @items.items.count).round(2)
  end

  def golden_items
    number_set = @items.items.map do |item|
      item.unit_price_to_dollars
    end
    std_dev = standard_deviation(number_set)
    @items.all.find_all do |item|
      item.unit_price_to_dollars > average_price_of_items + 2 * std_dev
    end
  end

  def merchants_with_high_item_count
    number_set = item_count_by_merchant.map { |item_count| item_count[1] }
    mean = find_mean(number_set)
    std = standard_deviation(number_set)
    merchant_and_ave = item_count_by_merchant.find_all { |merchant| merchant[1] > std + mean }
    merchant_and_ave.map { |m_a| @merchants.find_by_id(m_a[0])}
  end

  def item_count_by_merchant
    items_by_merchant.map { |items| [items[0], items[1].count] }
  end

  def average_average_price_per_merchant
    find_mean(average_price_per_merchant).round(2)
  end

  def average_price_per_merchant
    items_by_merchant.map do |items|
      sum(items[1].map { |also_item| also_item.unit_price }) /items[1].count
    end
  end

  def items_by_merchant
    @items.all.group_by { |item| item.merchant_id }
  end

  def average_item_price_for_merchant(merchant_id)
     sum_by_merchant = items_by_merchant.map do |items|
      [items[0], sum(items[1].map { |also_item| also_item.unit_price }) /items[1].count]
    end
    found_merchant = sum_by_merchant.find do |index_0, index_1|
       index_0 == merchant_id
    end
    found_merchant[1].round(2)
  end

  def average_items_per_merchant_standard_deviation
    item_array_per_merchant = item_count_by_merchant.map do |items|
      items[1]
    end
    standard_deviation(item_array_per_merchant).to_f.round(2)
  end

  def average_invoices_per_merchant
    find_mean(invoices_for_merchants.map { |merch, invs| invs.count }).round(2)
  end

  def invoices_for_merchants
    @invoices.all.group_by { |invoice| invoice.merchant_id }
  end

  def average_invoices_per_merchant_standard_deviation
    standard_deviation(invoices_for_merchants.map { |merch, invs| invs.count}).to_f.round(2)
  end

  def top_merchants_by_invoice_count
    top_merchs_w_invoices = invoices_for_merchants.find_all do |merchant, invoices|
      invoices.count > average_invoices_per_merchant + 2 * average_invoices_per_merchant_standard_deviation
    end
    top_merchs_w_invoices.map do |merchant_id, invoices|
      @merchants.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    top_merchs_w_invoices = invoices_for_merchants.find_all do |merchant, invoices|
      invoices.count < average_invoices_per_merchant - 2 * average_invoices_per_merchant_standard_deviation
    end
    top_merchs_w_invoices.map do |merchant_id, invoices|
      @merchants.find_by_id(merchant_id)
    end
  end

  def top_days_by_invoice_count
    top_days = invoices_by_day.find_all do |day, invoices|
      invoices.count > ave_invoices_per_day + std_dev_inv_per_day
    end
    top_days.map! { |day, invoices| day }
    convert_to_day_names(top_days)
  end

  def convert_to_day_names(days)
    day_names = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday",
            3 => "Wednesday", 4 => "Thursday", 5 => "Friday",
            6 => "Saturday"}
    days.map { |day| day_names[day.to_i] }
  end

  def ave_invoices_per_day
    @invoices.all.count / 7
  end

  def std_dev_inv_per_day
    number_set = invoices_by_day.map do |day, invoices|
      invoices.count
    end
    standard_deviation(number_set)
  end

  def invoices_by_day
    @invoices.all.group_by do |invoice|
      invoice.created_at.strftime("%w")
    end
  end

  def invoice_status(status)
    invoices_w_status = @invoices.all.count { |invoice| invoice.status == status }
    (invoices_w_status / @invoices.all.count.to_f * 100).round(2)
  end

  def total_price_per_day(date)
    by_date = @invoice_item.find_all do |item|
      item.created_at == date
    end
    tot_of_all_prices = by_date.all.inject(0) do |sum, item|
      sum + item.unit_price_to_dollars
    end
    tot_of_all_prices
  end

  def invoice_paid_in_full?(invoice_id)
    return false if @transactions.find_all_by_invoice_id(invoice_id) == []
    @transactions.find_all_by_invoice_id(invoice_id).all? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_total_by_item = @invoice_items.find_all_by_invoice_id(invoice_id).map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    sum(invoice_total_by_item)
  end
end
