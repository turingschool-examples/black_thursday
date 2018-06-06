class SalesAnalyst
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(items, merchants, invoices,
                 invoice_items, transactions, customers)
    @items = items
    @merchants = merchants
    @invoices = invoices
    @invoice_items = invoice_items
    @transactions = transactions
    @customers = customers
  end

  def average_items_per_merchant
    (@items.all.length.to_f / @merchants.all.length).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    items      = @items.find_all_by_merchant_id(merchant_id)
    sum_prices = items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
     return (sum_prices / items.length).round(2)
  end

  def average_average_price_per_merchant
    sum_avgs = @merchants.all.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    return (sum_avgs / @merchants.all.length).round(2)
  end

  def mean(set)
    set.reduce(0) do |sum, num|
      sum += num
    end.to_f / set.length
  end

  def sum(array)
    array.reduce(0) do |sum, num|
      sum += num
    end
  end

  def standard_deviation(mean, set)
    root = set.map do |num|
      (num - mean) ** 2
    end.reduce(0) do |sum, num|
      sum += num
    end / (set.length - 1)

    Math.sqrt(root).round(2)
  end

  def count_items_per_merchant
    collector = Hash.new(0)
    @items.all.reduce(collector) do |collector, item|
      collector[item.merchant_id] += 1
      collector
    end
  end

  def average_items_per_merchant_standard_deviation
    merchant_items = count_items_per_merchant
    temp_mean = mean(merchant_items.values)
    standard_deviation(temp_mean, merchant_items.values)
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    average_item_count = average_items_per_merchant
    cutoff = sd + average_item_count

    merchant_items = count_items_per_merchant

    merchant_ids = merchant_items.reduce([]) do |collector, (key, value)|
      if value >= cutoff
        collector << key
      end
      collector
    end
    merchant_ids.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end

  def golden_items
    item_price_array = @items.all.reduce([]) do |collector, item|
      collector << item.unit_price
    end

    average_price = mean(item_price_array)
    sd = standard_deviation(average_price, item_price_array)

    @items.all.reduce([]) do |collector, item|
      if item.unit_price >= (2 * sd + average_price)
        collector << item
      end
      collector
    end
  end

  def average_invoices_per_merchant
    total_merchants = @invoices.all.map do |invoice|
      invoice.merchant_id
    end.uniq.length
    (@invoices.all.length.to_f / total_merchants).round(2)
  end

  def count_invoices_by_merchant
    collector = Hash.new(0)
    @invoices.all.reduce(collector) do |collector, invoice|
      collector[invoice.merchant_id] += 1
      collector
    end
  end

  def average_invoices_per_merchant_standard_deviation
    merchant_invoices = count_invoices_by_merchant
    temp_mean = mean(merchant_invoices.values)
    standard_deviation(temp_mean, merchant_invoices.values)
  end

  def top_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    average_invoice_count = average_invoices_per_merchant
    cutoff = average_invoice_count + 2 * sd

    merchant_invoices = count_invoices_by_merchant

    merchant_ids = merchant_invoices.reduce([]) do |collector, (key, value)|
      if value >= cutoff
        collector << key
      end
      collector
    end
    merchant_ids.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    average_invoice_count = average_invoices_per_merchant
    cutoff = average_invoice_count - 2 * sd

    merchant_invoices = count_invoices_by_merchant

    merchant_ids = merchant_invoices.reduce([]) do |collector, (key, value)|
      if value <= cutoff
        collector << key
      end
      collector
    end
    merchant_ids.map do |merchant_id|
      @merchants.find_by_id(merchant_id)
    end
  end

  def top_days_by_invoice_count
    day_key = { 0 => 'Sunday',
                1 => 'Monday',
                2 => 'Tuesday',
                3 => 'Wednesday',
                4 => 'Thursday',
                5 => 'Friday',
                6 => 'Saturday' }

    invoices_by_day = @invoices.all.group_by do |invoice|
      invoice.created_at.wday
    end

    count_by_day = invoices_by_day.map do |key, invoice_array|
      invoice_array.length
    end

    avg_invoice_count = (@invoices.all.length / 7)
    sd = standard_deviation(avg_invoice_count, count_by_day)

    invoices_by_day.reduce([]) do |collector, (day, invoices)|
      if invoices.length >= (avg_invoice_count + sd)
        collector << day
      end
      collector
    end.map do |day_num|
      day_key[day_num]
    end
  end

  def invoice_status(status)
    matching_invoices = @invoices.all.select do |invoice|
      invoice.status == status
    end
    (matching_invoices.length / @invoices.all.length.to_f * 100).round(2)
  end

  def invoice_paid_in_full?(id)
    transactions_by_invoice = @transactions.find_all_by_invoice_id(id)

    transactions_by_invoice.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(id)
    total_price_by_quantity = @invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
    sum(total_price_by_quantity)
  end

  def top_buyers(num = 20)
    invoices_by_customer = @invoices.all.group_by do |invoice|
      invoice.customer_id
    end
    paid_invoices_by_customer = invoices_by_customer.reduce({}) do |collector, (customer, invoice_array)|
      collector[customer] = invoice_array.select do |invoice|
        invoice_paid_in_full?(invoice.id)
      end
      collector
    end
    totals_by_customer = paid_invoices_by_customer.reduce({}) do |collector, (customer, paid_invoice_array)|
      collector[customer] = paid_invoice_array.map do |invoice|
        invoice_total(invoice.id)
      end
      collector
    end.reduce({}) do |collector, (customer, total_array)|
      collector[customer] = sum(total_array)
      collector
    end
    customer_ids_in_order = totals_by_customer.sort_by do |id, value|
      value
    end.reverse
    customer_ids_in_order.slice(0...num).map do |customer_sub_array|
      @customers.find_by_id(customer_sub_array[0])
    end
  end

  def top_merchant_for_customer(cust_id)
    customer_invoices = @invoices.find_all_by_customer_id(cust_id)

    invoices_by_merchant = customer_invoices.group_by do |customer_invoice|
      customer_invoice.merchant_id
    end
    invoice_items_by_merchant = invoices_by_merchant.reduce({}) do |collector, (key, value)|
      collector[key] = value.flat_map do |invoice|
        @invoice_items.find_all_by_invoice_id(invoice.id)
      end
      collector
    end
    quantity_of_items = invoice_items_by_merchant.reduce({}) do |collector, (key, value)|
      collector[key] = value.map do |invoice_item|
        invoice_item.quantity
      end
      collector
    end
    summed_items = quantity_of_items.reduce({}) do |collector, (key, value)|
      collector[key] = sum(value)
      collector
    end
    top_merchant = summed_items.max_by do |key, value|
      value
    end
    @merchants.find_by_id(top_merchant[0])
  end

  def one_time_buyers
    invoices_by_customer = @invoices.all.group_by do |invoice|
      invoice.customer_id
    end
    customers = invoices_by_customer.select do |key, value|
      value.length == 1
    end.keys
    customers.map do |key, value|
      @customers.find_by_id(key)
    end
  end

  def one_time_buyers_top_item
    one_time_customers = one_time_buyers
    invoices = one_time_customers.flat_map do |customer|
      @invoices.find_all_by_customer_id(customer.id)
    end
    paid_invoices = invoices.select do |invoice|
      invoice_paid_in_full?(invoice.id)
    end

    invoice_items = paid_invoices.flat_map do |invoice|
      @invoice_items.find_all_by_invoice_id(invoice.id)
    end
    default_to_zero_hash = Hash.new(0)
    items = invoice_items.reduce(default_to_zero_hash) do |collector, invoice_item|
      collector[invoice_item.item_id] += invoice_item.quantity
      collector
    end
    max_id = items.max_by do |item, count|
      count
    end
    @items.find_by_id(max_id.first)
  end

  def best_invoice_by_revenue
    valid_invoices = @invoices.all.select do |invoice|
      invoice_paid_in_full? invoice.id
    end
    totals_by_invoice = valid_invoices.reduce({}) do |collector, invoice|
      collector[invoice.id] = invoice_total(invoice.id)
      collector
    end
    max_id = totals_by_invoice.max_by do |invoice_id, value|
      value
    end
    @invoices.find_by_id(max_id.first)
  end

  def best_invoice_by_quantity
    valid_invoices = @invoices.all.select do |invoice|
      invoice_paid_in_full? invoice.id
    end
    quantity_per_invoice = valid_invoices.reduce({}) do |collector, invoice|
      collector[invoice.id] = []
      invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
      invoice_items.map do |invoice_item|
        collector[invoice.id] << invoice_item.quantity
      end
      collector
    end.reduce({}) do |collector, (invoice_id, invoice_array)|
      collector[invoice_id] = sum(invoice_array)
      collector
    end
    max_id = quantity_per_invoice.max_by do |invoice_id, quantity|
      quantity
    end
    @invoices.find_by_id(max_id.first)
  end

  def items_bought_in_year(customer_id, year)
    customer_invoices = @invoices.find_all_by_customer_id(customer_id)
    valid_transactions = customer_invoices.map do |invoice|
      if invoice_paid_in_full?(invoice.id)
        invoice
      end
    end.compact
    invoice_items = valid_transactions.map do |valid_invoice|
      if valid_invoice.created_at.year == year
        @invoice_items.find_all_by_invoice_id(valid_invoice.id)
      end
    end.compact.flatten
    items = invoice_items.map do |invoice_item|
      if invoice_item == nil
        nil
      else
        @items.find_by_id(invoice_item.item_id)
      end
    end
    items
  end

  def highest_volume_items(customer_id)
    customer_invoices = @invoices.find_all_by_customer_id(customer_id)
    invoice_items = customer_invoices.map do |customer_invoice|
      @invoice_items.find_all_by_invoice_id(customer_invoice.id)
    end.flatten
    highest_number = invoice_items.max_by do |invoice_item|
      invoice_item.quantity
    end.quantity
    high_volume_invoice_items = invoice_items.find_all do |invoice_item|
      invoice_item.quantity == highest_number
    end
    items = high_volume_invoice_items.map do |high_volume_invoice_item|
      @items.find_by_id(high_volume_invoice_item.item_id)
    end
    items
  end

  def customers_with_unpaid_invoices
    unpaid_invoices = @invoices.all.find_all do |invoice|
      invoice_paid_in_full?(invoice.id) == false
    end
    unpaid_customer_ids = unpaid_invoices.map do |unpaid_invoice|
      unpaid_invoice.customer_id
    end.uniq
    unpaid_customers = unpaid_customer_ids.map do |unpaid_customer_id|
      @customers.find_by_id(unpaid_customer_id)
    end
    unpaid_customers
  end
end
