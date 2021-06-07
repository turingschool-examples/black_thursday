module Countable
  def items_by_merch_count
    merch_items_hash.values.map do |item_array|
      item_array.count
    end
  end

  def invoices_by_merch_count
    count = merch_invoices_hash.values.map do |invoice_array|
      invoice_array.count
    end
    count
  end

  def top_days_by_invoice_count
    days_high_count = days_invoices_hash.select do |days, invoices|
      invoices > (average_invoices_per_day + avg_inv_per_day_std_dev)
    end
    days_high_count.keys
  end
end
