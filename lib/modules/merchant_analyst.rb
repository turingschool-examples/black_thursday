module MerchantAnalyst
  def self.merchants_with_pending_invoices(merchants)
    merchants.select {|merchant| pending_invoices?(merchant)}
  end

  def self.pending_invoices?(merchant)
    merchant.invoices.any? {|invoice| !invoice.is_paid_in_full?}
  end

  def self.merchants_with_only_one_item(merchants)
    merchants.select {|merchant| merchant.items.count == 1}
  end

  def self.merchants_with_only_one_item_registered_in_month(month, merch)
    merchants_by_month(month, merch) & merchants_with_only_one_item(merch)
  end

  def self.merchants_by_month(month, merchants)
    merchants.select {|m| m.created_at.strftime("%B") == month.capitalize}
  end

  def self.most_sold_item_for_merchant(merchant_id, e, i)
    top_items(merchant_id, e, i).keys.map{|id| e.find_item_by_id(id)}
  end

  def self.top_items(merchant_id, e, i)
    top_quantity = item_quantity(merchant_id, e, i).max_by {|i, q| q}
    item_quantity(merchant_id, e, i).select {|i, q| q == top_quantity[1]}
  end

  def self.item_quantity(merchant_id, engine, invoices)
    items_sorted(merchant_id, engine, invoices).reduce({}) do |hash, element|
      hash[element[0]]  = element[1] if !hash[element[0]]
      hash[element[0]] += element[1]
      hash
    end
  end

  def self.items_sorted(merchant_id, e, i)
    id_and_total_quantity_of_item(merchant_id, e, i).sort_by(&:last).reverse
  end

  def self.id_and_total_quantity_of_item(merchant_id, engine, invoices)
    inv = completed_invoices(engine.find_invoices_by_merchant_id(merchant_id))
    inv.flat_map(&:invoice_items).reduce({}) do |hash, inv_item|
      hash[inv_item.item_id]  = 0 if !hash[inv_item.item_id]
      hash[inv_item.item_id] += inv_item.quantity
      hash
    end
  end

  def self.best_item_for_merchant(merchant_id, engine)
    item_id = revenue(merchant_id, engine).max_by {|i, r| r}.first
    engine.find_item_by_id(item_id)
  end

  def self.completed_invoices(invoices)
    invoices.reject {|invoice| pending?(invoice)}
  end

  def self.pending?(invoice)
    invoice.transactions.all? { |t| t.result == "failed" }
  end

  def self.revenue(merchant_id, engine)
    paid_invoices(merchant_id, engine).reduce({}) do |hash, item|
      build_revenue_hash(hash, item)
    end
  end

  def self.paid_invoices(merchant_id, engine)
    engine.merchants
          .find_by_id(merchant_id)
          .invoices
          .flat_map {|inv| inv.invoice_items if inv.is_paid_in_full?}
          .compact
  end

  def self.build_revenue_hash(hash, item)
    if hash[item.item_id]
       hash[item.item_id] += item.quantity * item.unit_price
    else
       hash[item.item_id]  = item.quantity * item.unit_price
    end
   hash
  end
end