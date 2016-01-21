module MerchantAnalysis

  def top_revenue_earners(merchants = 20)
    earners_with_rev.to_h.keys[0,merchants]
  end

  def earners_with_rev
    sort_earners.reject {|k,v| v.to_f == 0.0}
  end

  def sort_earners
    merchant_and_total_rev_array.to_h.sort_by{|k,v| -v}
  end

  def merchant_and_total_rev_array
    se.merchants.all.map do |merchant|
      [merchant, merchant.total_revenue]
    end
  end

  def merchants_ranked_by_revenue
    earners_with_rev.to_h.keys
  end

  def merchants_with_pending_invoices
    se.merchants.all.find_all do |merchant|
      merchant.invoice_status_pending
    end
  end

  def number_of_merchants
    se.merchants.all.count
  end

  def merchants_with_only_one_item
    se.merchants.all.find_all do |merchant|
      merchant.merchant_with_one_item
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = se.merchants.find_by_id(merchant_id)
    sort_earners.to_h[merchant]
  end

  def merchants_with_only_one_item_registered_in_month(month)
    merchants_with_only_one_item.find_all do |merchant|
      merchant.created_at.strftime("%B") == month
    end
  end

  def two_standard_dev_below_mean_invoices
    average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
  end

  def one_standard_dev_above_mean_value_top_days
    average_invoices_per_day_standard_deviation + average_invoices_per_day
  end

  def one_standard_dev_above_mean_value
    average_items_per_merchant + average_items_per_merchant_standard_deviation
  end

  def days_of_the_week_hash
    @wday_created = { Sunday: 0,
                      Monday: 0,
                     Tuesday: 0,
                   Wednesday: 0,
                    Thursday: 0,
                      Friday: 0,
                    Saturday: 0
                  }
  end

  def hash_of_invoices_to_day_of_the_week
    days_of_the_week_hash
    se.invoices.all.each do |invoice|
      day = invoice.created_at.strftime('%A').to_sym
      @wday_created[day] = @wday_created[day] += 1
    end
    @wday_created
  end

  def account_for_zero_items(total_items)
    if total_items.count == 0
      0
    else
      total_items.reduce(:+) / total_items.count
    end
  end

  def invoices_per_day_of_the_week
    @wday_created.values
  end

  def average_invoices_per_day
    (number_of_invoices / 7).round(2)
  end

  def variance_days
    sum_deviations_from_the_mean_days / (7 - 1)
  end

  def best_item_for_merchant(merchant_id)
    invoices      = se.invoices.find_all_by_merchant_id(merchant_id)
    paid_invoices = invoices.find_all { |invoice| invoice.is_paid_in_full? }
    invoice_items  = paid_invoices.flat_map do |invoice|
      se.invoice_items.find_all_by_invoice_id(invoice.id)
    end

    item_quantity = Hash.new(0)
    invoice_item_quantity = invoice_items.each do |invoice_item|
      item_quantity[invoice_item.item_id] += (invoice_item.revenue)
    end
    
    max_item = item_quantity.max_by { |k, v| v}
    ties = item_quantity.find_all do |key, value|
      value == max_item[1]
    end.map{|pair| pair[0]}

    best = ties.map do |item_id|
      se.items.find_by_id(item_id)
    end

    best.first
  end

end
