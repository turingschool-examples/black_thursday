require 'pry'

require_relative 'finderclass'

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

  # TO DO - TEST ME
  def percentage(fraction, all)
    (fraction / all.to_f ) * 100
  end

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

  def find_exceptional(collection, values, stds, method)
    case collection
    when Hash;  exceptional_from_hash(collection, values, stds, method)
    when Array; exceptional_from_array(collection, values, stds, method)
    end
  end

  def exceptional_from_hash(collection, values, stds, method)
    stds > 0 ? operator = :> : operator = :<
    std_limit = standard_dev_measure(values, stds)
    list = collection.find_all {|key, value|
      value.send(method).send(operator, std_limit)
    }.to_h
    return list
  end

  def exceptional_from_array(collection, values, stds, method)
    stds > 0 ? operator = :> : operator = :<
    std_limit = standard_dev_measure(values, stds)
    list = collection.find_all {|object|
      object.send(method).send(operator, std_limit)
    }
    return list
  end


  # --- Item Repo Analysis Methods ---

  def merchant_stores
    groups = FinderClass.group_by(@items.all, :merchant_id)
  end

  def merchant_store_item_counts(groups)
    vals = groups.values.inject([]) { |arr, shop| arr << shop.count }
  end

  def average_items_per_merchant
    groups = merchant_stores
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

  def merchants_with_high_item_count # find all merchants > one std of items
    groups    = merchant_stores
    values      = merchant_store_item_counts(groups)
    all_above = find_exceptional(groups, values, 1, :count)
    merch_ids = all_above.keys
    list = FinderClass.match_by_data(@merchants.all, merch_ids, :id)
    return list
  end

  def average_item_price_for_merchant(id)
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
    above    = find_exceptional(@items.all, prices, 2, :unit_price)
  end


  # --- Invoice Repo Analysis Methods ---

  def invoices_grouped_by_merchant
    groups = FinderClass.group_by(@invoices.all, :merchant_id)
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
    top = find_exceptional(groups, counts, 2, :count)
    merch_ids = top.keys
    top_merchants = FinderClass.match_by_data(@merchants.all, merch_ids, :id )

  end

  def bottom_merchants_by_invoice_count  # two standard deviations below the mean
    groups = invoices_grouped_by_merchant
    counts = invoice_counts_per_merchant
    worst = find_exceptional(groups, counts, -2, :count)
    merch_ids = worst.keys
    bottom_merchants = FinderClass.match_by_data(@merchants.all, merch_ids, :id )
  end

  def top_days_by_invoice_count
    groups = @invoices.all.group_by { |invoice| invoice.created_at.wday}
    values = groups.map { |day, inv| inv.count }
    top = find_exceptional(groups, values, 1, :count)
    top_as_word = top.keys.map { |day| FinderClass.day_of_week(day) }
  end

  def invoice_status(status)
    all = @invoices.all.count.to_f
    found = @invoices.find_all_by_status(status).count
    percent = percentage(found, all).round(2)
    # percent = ( found / all ) * 100
    # percent.round(2)
  end


  # --- Transaction Repo Analysis Methods ---

  def invoice_paid_in_full?(invoice_id) # Paid in full if t/f
    sale = @transactions.find_all_by_invoice_id(invoice_id)
    sale.any? { |trans| trans.result == :success }
  end

  def invoice_items_of_successful_transactions(invoice_id)
    sold = invoice_paid_in_full?(invoice_id)
    items_by_invoice = @invoice_items.find_all_by_invoice_id(invoice_id) if sold
  end

  def invoice_total(invoice_id)
    items_by_invoice = invoice_items_of_successful_transactions(invoice_id)
    if items_by_invoice
      sum = items_by_invoice.inject(0) { |sum, item|
        cost = item.quantity * item.unit_price_to_dollars
        sum += cost
      }
      return sum
      # return BigDecimal.new(sum, 4)
      # TO DO - I think the SpecHarness is wrong -- wants both an int & BigDecimal
    end
  end


end
