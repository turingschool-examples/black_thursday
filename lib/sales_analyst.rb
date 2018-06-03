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
    (@items.all.length.to_f/@merchants.all.length).round(2)
  end

  def average_item_price_for_merchant(merchant_id)
    items      = @items.find_all_by_merchant_id(merchant_id)
    sum_prices = items.reduce(0) do |sum, item|
      sum += item.unit_price
    end
     return (sum_prices/items.length).round(2)
  end

  def average_average_price_per_merchant
    sum_avgs = @merchants.all.reduce(0) do |sum, merchant|
      sum += average_item_price_for_merchant(merchant.id)
    end
    return (sum_avgs/@merchants.all.length).round(2)
  end

  def mean(set)
    set.reduce(0) do |sum, num|
      sum += num
    end.to_f / set.length
  end

  def standard_deviation(mean, set)
    root = set.map do |num|
      (num - mean) ** 2
    end.reduce(0) do |sum, num|
      sum += num
    end / (set.length - 1)

    Math.sqrt(root).round(2)
  end

  def average_items_per_merchant_standard_deviation
    # refactor this block into a separate method
    merchant_items = @items.all.reduce({}) do |collector, item|
      if collector[item.merchant_id]
        collector[item.merchant_id] += 1
      else
        collector[item.merchant_id] = 1
      end
      collector
    end
    temp_mean = mean(merchant_items.values)
    standard_deviation(temp_mean, merchant_items.values)
  end

  def merchants_with_high_item_count
    sd = average_items_per_merchant_standard_deviation
    average_item_count = average_items_per_merchant
    cutoff = sd + average_item_count

    merchant_items = @items.all.reduce({}) do |collector, item|
      if collector[item.merchant_id]
        collector[item.merchant_id] += 1
      else
        collector[item.merchant_id] = 1
      end
      collector
    end

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

  def average_invoices_per_merchant_standard_deviation
    # refactor this block into a separate method
    merchant_invoices = @invoices.all.reduce({}) do |collector, invoice|
      if collector[invoice.merchant_id]
        collector[invoice.merchant_id] += 1
      else
        collector[invoice.merchant_id] = 1
      end
      collector
    end
    temp_mean = mean(merchant_invoices.values)
    standard_deviation(temp_mean, merchant_invoices.values)
  end

  def top_merchants_by_invoice_count
    sd = average_invoices_per_merchant_standard_deviation
    average_invoice_count = average_invoices_per_merchant
    cutoff = average_invoice_count + 2 * sd

    merchant_invoices = @invoices.all.reduce({}) do |collector, invoice|
      if collector[invoice.merchant_id]
        collector[invoice.merchant_id] += 1
      else
        collector[invoice.merchant_id] = 1
      end
      collector
    end

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

    merchant_invoices = @invoices.all.reduce({}) do |collector, invoice|
      if collector[invoice.merchant_id]
        collector[invoice.merchant_id] += 1
      else
        collector[invoice.merchant_id] = 1
      end
      collector
    end

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
    day_key = { 0 => "Sunday",
                1 => "Monday",
                2 => "Tuesday",
                3 => "Wednesday",
                4 => "Thursday",
                5 => "Friday",
                6 => "Saturday" }

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
    @transactions.find_all_by_invoice_id(id).any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(id)
    @invoice_items.find_all_by_invoice_id(id).map do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end.reduce(0) do |sum, num|
      sum += num
    end
  end

  def top_buyers(num = 20)
    invoices_by_customer = @invoices.all.group_by do |invoice|
      invoice.customer_id
    end
    # paid_invoices_by_customer = invoices_by_customer.each do |customer, invoice_array|
    #   invoice_array.select do |invoice|
    #     invoice_paid_in_full?(invoice.id)
    #   end
    # end
    totals_by_customer = invoices_by_customer.reduce({}) do |collector, (customer, paid_invoice_array)|
      collector[customer] = paid_invoice_array.map do |invoice|
        invoice_total(invoice.id)
      end
      collector
    end.reduce({}) do |collector, (customer, total_array)|
      collector[customer] = total_array.reduce(0) do |sum, total|
        sum += total
      end
      collector
    end
    customer_ids_in_order = totals_by_customer.sort_by do |id, value|
      value
    end
    p customer_ids_in_order
  end
end

















