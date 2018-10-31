require_relative './statistics'

class SalesAnalyst
  include Statistics

  def initialize(input)
    @merchants = input[:merchants]
    @items = input[:items]
    @invoices = input[:invoices]
    @transactions = input[:transactions]
    @invoice_items = input[:invoice_items]
    @customers = input[:customers]
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
    (tot_of_all_prices / @items.all.count).round(2)
  end

  def golden_items
    number_set = @items.all.map do |item|
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

  def total_revenue_by_date(date)
    actual = date.strftime("%Y-%m-%d")
    invoice_from_date = @invoices.all.find_all do |invoice|
      invoice.created_at.strftime("%Y-%m-%d") == actual
    end
    valid_invoices = invoice_from_date.select do |invoice|
      @transactions.all.any? do |trans|
        trans.invoice_id == invoice.id &&
        trans.result == :success
      end
    end
    items_from_invoice = valid_invoices.map do |invoice|
        @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    items_from_invoice.inject(0) do |sum, item_invoice|
      sum + item_invoice.quantity * item_invoice.unit_price
    end.round(2)
  end

  def merchants_with_pending_invoices
    pending_invoices = @invoices.all.reject do |invoice|
      min_one_transaction_passed(invoice)
    end
    merchants_and_invoices = pending_invoices.group_by do |invoice|
      @merchants.find_by_id(invoice.merchant_id)
    end
    merchants_and_invoices.map do |merchant, invoices|
     merchant
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant_invoices = @invoices.all.select { |invoice| invoice.merchant_id == merchant_id }
    all_merchant_invoice_items = merchant_invoices.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    all_merchant_invoice_items = all_merchant_invoice_items.select do |ii|
      min_one_transaction_passed(@invoices.find_by_id(ii.invoice_id))
    end
    merchant_qtys = all_merchant_invoice_items.group_by do |invoice_item|
      invoice_item.quantity
    end.to_a
    merchant_maxs = merchant_qtys.select { |qty, invoice| qty == merchant_qtys.sort[-1][0] }
    merchant_maxs.map! { |maxs, invoice_item| invoice_item }
    merchant_maxs.flatten!
    merchant_maxs.map { |ii| @items.find_by_id(ii.item_id) }
  end

  def best_item_for_merchant(merchant_id)
    merchant_invoices = @invoices.all.select { |invoice| invoice.merchant_id == merchant_id }
    merchant_invoices = merchant_invoices.select { |invoice| min_one_transaction_passed(invoice) }
    merchant_qtys = merchant_invoices.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    merchant_qtys = merchant_qtys.group_by do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end.to_a
    merchant_maxs = merchant_qtys.select { |qty, invoice| qty == merchant_qtys.sort[-1][0] }
    merchant_maxs.map! { |maxs, invoice_item| invoice_item }
    merchant_maxs.flatten!
    if merchant_maxs.length == 1
      return @items.find_by_id(merchant_maxs[0].item_id)
    else
      return merchant_maxs.map { |ii| @items.find_by_id(ii.item_id) }
    end
  end

  def min_one_transaction_passed(invoice)
    invoice_transactions = @transactions.all.select do |transaction|
      transaction.invoice_id == invoice.id
    end
    invoice_transactions.any? { |transaction| transaction.result == :success }
  end


  def revenue_by_merchant(merchant_id)
    merchant_invoices = @invoices.all.select { |invoice| invoice.merchant_id == merchant_id }
    merchant_invoices = merchant_invoices.select do |invoice|
      # all_transaction_passed(invoice) && invoice.status != :returned
      min_one_transaction_passed(invoice)# && invoice.status != :returned
    end
    all_invoice_items_by_merchant = merchant_invoices.map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end.flatten
    all_invoice_items_by_merchant.reduce(0) do |sum, ii|
      ii.quantity * ii.unit_price + sum
    end
  end

  def top_revenue_earners(x = 20)
    rev = @merchants.all.map do |merchant|
      [revenue_by_merchant(merchant.id), merchant]
    end
    revenue_array = rev.sort_by do |revenue,merchant|
      revenue
    end
    top = revenue_array.max_by(x) do |revenue, merch|
      revenue
    end
    top_merchants = top.map do |revenue, merchant|
      merchant
    end
    top_merchants
  end

  def merchants_ranked_by_revenue
    top_revenue_earners(@merchants.all.count)
  end

  def merchants_with_only_one_item
    merch_and_items = @items.all.group_by { |item| item.merchant_id }.to_a
    a = merch_and_items.select { |merch_id, items| items.count == 1 }
    a.map { |merch_id, items| @merchants.find_by_id(merch_id) }
  end

  def one_time_buyers
    customer_and_invoices = @invoices.all.group_by do |invoice|
      invoice.customer_id
    end
    otb = customer_and_invoices.select do |customer, invoices|
      invoices.length == 1
    end
    otb.map do |customer, invoice|
      @customers.find_by_id(invoice.first.customer_id)
    end
  end

  def merchants_with_only_one_item_registered_in_a_month(month)
    merchants_in_month = @merchants.all.find_all do |merchant|
      month == merchant.created_at.strftime("%B") 
    end
  end

end
