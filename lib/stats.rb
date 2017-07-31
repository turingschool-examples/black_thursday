module Stats

  def average(info)
    (info.reduce(:+)/info.count.to_f).round(2)
  end

  def variance(info)
    current_av = average(info)
    info.map {|num| (current_av-num)**2}
  end

  def standard_deviation(info)
    average = average(info)
    variance = variance(info)
    Math.sqrt(average(variance)).round(2)
  end

  def one_standard_deviation_bar
    avg     = average_items_per_merchant
    std_dev = average_items_per_merchant_standard_deviation
    avg + std_dev
  end

  def num_items_per_merchant
    se.all_merchants.reduce({}) do |result, merchant|
      result[merchant] = merchant.items.count
      result
    end
  end

  def merchant_items_prices(id)
    merchant = se.merchants.find_by_id(id)
    merchant.items.map {|item| item.unit_price}
  end

  def merchant_id_item_group
    se.all_items.group_by {|item| item.merchant_id}
  end

  def item_prices
    se.all_items.map {|item| item.unit_price}
  end

  def item_two_std_dev(info)
    avg     = average(info)
    std_dev = standard_deviation(info) * 2
    avg + std_dev
  end

  def item_std_dev(array, item)
    if item.unit_price > item_two_std_dev(item_prices)
      array << item
    end
  end

  def num_invoices_per_merchant
    se.all_merchants.reduce({}) do |result, merchant|
      result[merchant] = merchant.invoices.count
      result
    end
  end

  def invoice_two_std_dev(info)
    avg     = average(info)
    std_dev = standard_deviation(info) * 2
    avg + std_dev
  end

  def invoice_std_dev(array, merchant, invoices, bar)
    array << merchant if invoices > bar
  end

  def invoice_2_std_dev_below(info)
    avg     = average(info)
    std_dev = standard_deviation(info) * 2
    avg - std_dev
  end

  def bad_merchants(array, merchant, invoices, bar)
    array <<merchant if invoices < bar
  end

  def num_invoice_days
    se.all_invoices.map {|invoice| Date::DAYNAMES[invoice.created_at.wday]}
  end

  def invoices_by_day_count
    num_invoice_days.each_with_object(Hash.new(0)) do |day,result|
      result[day] += 1
    end
  end

  def invoice_std_dev_bar
    invoice_day = invoices_by_day_count.values
    avg         = average(invoice_day)
    std_dev     = standard_deviation(invoice_day)
    avg + std_dev
  end

  def statuses
    se.all_invoices.group_by {|invoice| invoice.status}
  end


end
