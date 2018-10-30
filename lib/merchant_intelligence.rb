module MerchantIntelligence
  def merchants_with_high_item_count
    temp_sd = average_items_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_items_of_merchant(merchant) > average_items_per_merchant + temp_sd
    end
  end

  def top_merchants_by_invoice_count
    temp_sd = average_invoices_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_invoices_of_merchant(merchant) > average_invoices_per_merchant + temp_sd * 2
    end
  end

  def bottom_merchants_by_invoice_count
    temp_sd = average_invoices_per_merchant_standard_deviation
    @merchants.all.select do |merchant|
      num_invoices_of_merchant(merchant) < average_invoices_per_merchant - temp_sd * 2
    end
  end

  def num_items_of_merchant(merchant)
    @items.find_all_by_merchant_id(merchant.id).size
  end

  def num_invoices_of_merchant(merchant)
    @invoices.find_all_by_merchant_id(merchant.id).size
  end

  def merchants_ranked_by_revenue
    return @merchants.all if @merchants.sorted == true
    @merchants.sorted = true
    @merchants.instances = @merchants.all.sort_by { |merchant|
      revenue_by_merchant(merchant.id)
    }.reverse
  end

  def merchants_with_pending_invoices
    find_from_invoices(unsuccessful_invoices, 'Merchant').uniq
  end

  def merchants_with_only_one_item
    @merchants.all.select do |merchant|
      @items.all.one? do |item|
        item.merchant_id == merchant.id
      end
    end
  end

  def merchants_with_only_one_item_registered_in_month(month)
    month_num = Date::MONTHNAMES.find_index(month)
    @merchants.all.select do |merchant|
      merchant.created_at.month == month_num && \
      @items.all.one? do |item|
        item.merchant_id == merchant.id
      end
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant = @merchants.find_by_id(merchant_id)
    revenue_from_invoices(find_invoices_from(merchant))
  end

  def most_sold_item_for_merchant(merchant_id)
    invoices = successful_invoices.select { |invoice|invoice.merchant_id == merchant_id }
    invoice_items = invoices.map do |invoice|
      find_from_invoice(invoice, 'InvoiceItem')
    end.flatten

    item_count = Hash.new(0)

    invoice_items.each do |invoice_item|
      item_count[invoice_item.item_id] += invoice_item.quantity
    end
    max = 0
    item_count.sort_by {|k, v| -v}.reduce([]) do |result, (k, v)|
      break result if v < max
      max = v
      result << k
    end.map { |k,v| @items.find_by_id(k) }
  end

  def best_item_for_merchant(merchant_id)
    best_invoice_item = successful_invoices.select do |invoice|
      invoice.merchant_id == merchant_id
    end.collect do |invoice|
      find_from_invoice(invoice, 'InvoiceItem')
    end.flatten.max_by do |invoice_item|
      invoice_item.revenue
    end
    @items.find_by_id(best_invoice_item.item_id)
  end

  def top_revenue_earners(x=20)
    merchants_ranked_by_revenue[0..x-1]
  end
end
