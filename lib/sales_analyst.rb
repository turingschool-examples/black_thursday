require 'pry'


class SalesAnalyst

  attr_reader :merchants,
              :items,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(sales_engine)
    @engine = sales_engine

    @merchants     = @engine.merchants
    @items         = @engine.items
    @invoices      = @engine.invoices
    @invoice_items = @engine.invoice_items
    @transactions  = @engine.transactions
    @customers     = @engine.customers
  end

  # --- General Methods ---

  def group_by(repo, method)
    groups = repo.group_by { |object| object.send(method)}  #method is a symbol
  end   # returns a hash

  # Lets wait to see if this is useful in the other iterations
    #  we can use it in the Item Repo Analysis
  def create_values_array(hash, hash_method, rule_method)
    data    = hash.send(hash_method)
    values  = data.inject([]) {|arr, val| arr << val.send(rule_method) }
  end

  def sum(values)
    sum = values.inject(0) { |total, val| total += val.to_f }
  end   # returns an rounded float

  def average(values, ct = values.count)
    sum     = sum(values)
    ct      = ct.to_f
    average = (sum / ct)
  end   # returns an unrounded float

  def standard_deviation(values, mean) # Explicit steps
    floats      = values.map     { |val| val.to_f   }
    difference  = floats.map     { |val| val - mean }
    values      = difference.map { |val| val ** 2   }
    sample_ct   = (values.count - 1)
    div         = average(values, sample_ct)
    sqrt        = Math.sqrt(div)
    return sqrt.round(2)
  end   # returns float rounded to 2 places

  def standard_dev_measure(values, above_or_below, std = nil)
    mean = average(values)
    std == nil ? std = standard_deviation(values, mean) : std
    outside_this = mean + (std * above_or_below)
  end # returns a float


  # # WIP -- IGNORE THIS FOR NOW
  # # TO DO - Test Me
  # def best_or_worst_by_group(group, values, mean, above_or_below)
  #   mean = average(values)
  #   above_this = standard_dev_measure(values, mean, above_or_below)
  #   above = group.find_all { |key, collection| collection.count > above_this }.to_h
  # end
  #
  # # WIP -- IGNORE THIS FOR NOW
  # # TO DO - Test Me
  # def best_or_worst_by_repo(repo, values, mean, above_or_below)
  #   mean = average(values)
  #   above_this = standard_dev_measure(values, mean, above_or_below)
  #   above = group.find_all { |merch_id, items| items.count > std_high }.to_h
  # end



  # --- Item Repo Analysis Methods ---

  def merchant_stores
    groups = group_by(@items.all, :merchant_id)
  end

  def merchant_store_item_counts(groups)
    vals = groups.values.inject([]) { |arr, shop| arr << shop.count }
  end

  def average_items_per_merchant
    groups = group_by(@items.all, :merchant_id)
    vals   = merchant_store_item_counts(groups)
    mean   = average(vals)
    return mean.round(2)
  end

  def average_items_per_merchant_standard_deviation
    mean   = average_items_per_merchant
    groups = merchant_stores
    vals   = merchant_store_item_counts(groups)
    std    = standard_deviation(vals, mean)
  end

  def merchants_with_high_item_count
    # find all merchants > one std of items
    groups    = merchant_stores
    vals      = merchant_store_item_counts(groups)
    std_high  = standard_dev_measure(vals, 1)
    all_above = groups.find_all { |merch_id, items| items.count > std_high }.to_h
    merch_ids = all_above.keys
    list = merch_ids.map { |id| @merchants.all.find { |merch| merch.id == id } }
    list = list.to_a.flatten
    return list
  end

  def average_item_price_for_merchant(id)
    id    = id
    group = @items.find_all_by_merchant_id(id)
    total = group.inject(0) { |sum, item| sum += item.unit_price }
    count = group.count
    mean  = (total / count).round(2)
  end   # returns big decimal

  def average_average_price_per_merchant
    repo     = @merchants.all
    ids      = repo.map { |merch| merch.id }
    averages = ids.map { |id| average_item_price_for_merchant(id) }
    mean     = average(averages).round(2)
    mean     = BigDecimal(mean, 5)
  end   # returns a big decimal

  def golden_items # items with prices above 2 std of average price
    prices   = @items.all.map{ |item| item.unit_price }
    std_high = standard_dev_measure(prices, 2)
    above    = @items.all.find_all{|item| item.unit_price > std_high}.to_a
  end


  # --- Invoice Repo Analysis Methods ---

  def invoices_grouped_by_merchant
    groups = @invoices.all.group_by { |invoice| invoice.merchant_id }
  end


  def invoice_counts_per_merchant
    groups = invoices_grouped_by_merchant
    counts = groups.map { |id, invoices| invoices.count.to_f }
  end


  def average_invoices_per_merchant
    counts = invoice_counts_per_merchant
    mean = average(counts).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    counts = invoice_counts_per_merchant
    mean = average_invoices_per_merchant
    std = standard_deviation(counts, mean).round(2)
  end

  def top_merchants_by_invoice_count  # two standard deviations above the mean
    groups = invoices_grouped_by_merchant
    counts = invoice_counts_per_merchant
    std_high = standard_dev_measure(counts, 2)
    top = groups.find_all { |id, invoices| invoices.count > std_high }.to_h
    merch_ids = top.keys
    top_merchants = merch_ids.map { |id|
      @merchants.all.find_all { |merch| merch.id == id }
    }.flatten
  end

  def bottom_merchants_by_invoice_count  # two standard deviations below the mean
    groups = invoices_grouped_by_merchant
    counts = invoice_counts_per_merchant
    std_low = standard_dev_measure(counts, -2)
    top = groups.find_all { |id, invoices| invoices.count < std_low }.to_h
    merch_ids = top.keys
    top_merchants = merch_ids.map { |id|
      @merchants.all.find_all { |merch| merch.id == id }
    }.flatten
  end

  def top_days_by_invoice_count
    # TO DO - DATES NEED TO BE IMPLEMENTED
  end

  def invoice_status(status)
    all = @invoices.all.count.to_f
    found = @invoices.find_all_by_status(status).count
    percent = ( found / all ) * 100
    percent.round(2)
  end


  # --- Transaction Repo Analysis Methods ---

  def invoice_paid_in_full?(invoice_id)
    # An invoice is considered paid in full if it has a successful transaction  (ANY!)
    sale = @transactions.find_all_by_invoice_id(invoice_id)
    sale.any? { |trans| trans.result == :success }
  end

  # def successful_transactions_by_invoice_id(invoice_id)
  #   sale = @transactions.find_all_by_invoice_id(invoice_id)
  #   sale.find_all { |trans| trans.result == :success }
  # end

  # TO DO - DOES PENDING count as a sale??
  def invoice_was_not_returned?(invoice_id)
    invoice = @invoices.find_by_id(invoice_id)
    not_returned = invoice.status != :returned
  end

  # Is returned supposed to count towards revenue??
  def invoice_items_of_successful_transactions(invoice_id)
    sold = invoice_paid_in_full?(invoice_id) && invoice_was_not_returned?(invoice_id)
    items_by_invoice = @invoice_items.find_all_by_invoice_id(invoice_id) if sold
  end

  def invoice_total(invoice_id)
    # returns the total $ amount of the Invoice with the corresponding id.
    # Failed charges should never be counted in revenue totals or statistics.
    invoice_items_by_id = invoice_items_of_successful_transactions(invoice_id)
    if invoice_items_by_id
      sum = invoice_items_by_id.inject(0) { |sum, item|
        cost = item.quantity * item.unit_price_to_dollars
        sum += cost
      }
      return sum
    end
  end


end
