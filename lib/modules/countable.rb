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
end
