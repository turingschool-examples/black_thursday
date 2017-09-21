module ItemAnalyst
  def avg_item_price
    average(items.map(&:unit_price))
  end

  def avg_item_price_std_deviation
    standard_deviation(items.map(&:unit_price))
  end

  def top_items(merchant_id)
    top_quantity = item_quantity(merchant_id).max_by {|i, q| q}
    item_quantity(merchant_id).select {|i, q| q == top_quantity[1]}
  end

  def item_quantity(merchant_id)
    items_sorted(merchant_id).reduce({}) do |hash, element|
      hash[element[0]]  = element[1] if !hash[element[0]]
      hash[element[0]] += element[1]
      hash
    end
  end

  def items_sorted(merchant_id)
    id_and_total_quantity_of_item(merchant_id).sort_by(&:last).reverse
  end

  def revenue(merchant_id)
    paid_invoices(merchant_id).reduce({}) do |hash, item|
      build_revenue_hash(hash, item)
    end
  end

  def paid_invoices(merchant_id)
    engine.merchants
          .find_by_id(merchant_id)
          .invoices
          .flat_map {|inv| inv.invoice_items if inv.is_paid_in_full?}
          .compact
  end

  def build_revenue_hash(hash, item)
    if hash[item.item_id]
       hash[item.item_id] += item.quantity * item.unit_price
    else
       hash[item.item_id]  = item.quantity * item.unit_price
    end
   hash
  end
end
