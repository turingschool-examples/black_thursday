module MerchantAnalyst
  def merchants_with_high_item_count
    std_dev = average_items_per_merchant_standard_deviation
    item_num_mean = find_mean(number_of_items_per_merchant)
    high_item_count_merchants = []
    @all_items_per_merchant.each_pair do |merchant,items|
      if std_dev_above_mean(items.count, item_num_mean, std_dev) >= 1
        high_item_count_merchants << @sales_engine.merchants.find_by_id(merchant)
      end
    end
    high_item_count_merchants
  end

  def top_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    invoice_num_mean = find_mean(number_of_invoices_per_merchant)
    high_invoice_count_merchants = []
    @all_invoices_per_merchant.each_pair do |merchant, invoices|
      if std_dev_above_mean(invoices.count, invoice_num_mean, std_dev) >= 2
        high_invoice_count_merchants << @sales_engine.merchants.find_by_id(merchant)
      end
    end
    high_invoice_count_merchants
  end

  def bottom_merchants_by_invoice_count
    std_dev = average_invoices_per_merchant_standard_deviation
    invoice_num_mean = find_mean(number_of_invoices_per_merchant)
    low_invoice_count_merchants = []
    @all_invoices_per_merchant.each_pair do |merchant, invoices|
      if std_dev_above_mean(invoices.count, invoice_num_mean, std_dev) <= -2
        merchants = @sales_engine.merchants.find_by_id(merchant)
        low_invoice_count_merchants << merchants
      end
    end
    low_invoice_count_merchants
  end
end
