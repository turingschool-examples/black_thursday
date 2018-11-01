module ItemAnalyst

  def average_price_of_items
    tot_of_all_prices = @items.all.inject(0) do |sum, item|
      sum + item.unit_price_to_dollars
    end
    (tot_of_all_prices / @items.all.count).round(2)
  end

  def golden_items
    number_set = @items.all.map { |item| item.unit_price_to_dollars }
    std_dev = standard_deviation(number_set)
    @items.all.find_all do |item|
      item.unit_price_to_dollars > average_price_of_items + 2 * std_dev
    end
  end

  def most_sold_item_for_merchant(merchant_id)
    merchant_invoices = @invoices.find_all_by_merchant_id(merchant_id)
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
    @items.find_by_id(merchant_maxs[0].item_id)
  end

  def merchants_with_only_one_item
    merch_and_items = @items.all.group_by { |item| item.merchant_id }.to_a
    a = merch_and_items.select { |merch_id, items| items.count == 1 }
    a.map { |merch_id, items| @merchants.find_by_id(merch_id) }
  end

  def average_items_per_merchant_standard_deviation
    item_array_per_merchant = item_count_by_merchant.map do |items|
      items[1]
    end
    standard_deviation(item_array_per_merchant).to_f.round(2)
  end

end
