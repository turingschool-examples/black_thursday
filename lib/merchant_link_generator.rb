module MerchantRelationshipGenerator

  def generate_merchant_relationships
    @merchant_ids_with_invoice_ids   ||= link_merchant_ids_with_invoice_ids
    @merchant_ids_with_invoice_items ||= link_merchant_ids_with_invoice_items
    @merchant_ids_with_total_revenue ||= link_merchants_with_total_revenue
    @merchants_with_items            ||= link_merchants_with_items
    @merchants_with_invoices         ||= link_merchants_with_invoices
    @merchants_with_prices           ||= link_merchants_with_prices
  end

  def link_merchant_ids_with_invoice_ids
    merchant_ids_and_invoice_ids = Hash.new { |hash, key| hash[key] = [] }
    invoices.all.each do |invoice|
      if invoice.is_paid_in_full?
        merchant_ids_and_invoice_ids[invoice.merchant_id] << invoice.id
      end
    end
    merchant_ids_and_invoice_ids
  end

  def link_merchant_ids_with_invoice_items
    @merchant_ids_with_invoice_ids.transform_values do |invoice_ids|
      invoice_ids.map do |invoice_id|
        invoice_items.find_all_by_invoice_id(invoice_id)
      end.flatten
    end
  end

  def link_merchants_with_total_revenue
    @merchant_ids_with_invoice_items.transform_values do |invoice_items|
      invoice_items.map do |invoice_item|
        invoice_item.unit_price * invoice_item.quantity
      end.sum
    end
  end

  def link_merchants_with_items
    merchants_and_items = {}
    merchants.all.map do |merchant|
      merchants_and_items[merchant] = items.find_all_by_merchant_id(merchant.id)
    end
    merchants_and_items
  end

  def link_merchants_with_invoices
    merchants_and_invoices = {}
    merchants.all.map do |merch|
      merchants_and_invoices[merch] = get_invoices_from_merchant_id(merch.id)
    end
    merchants_and_invoices
  end

  def link_merchants_with_prices
    merchants_with_items.transform_values do |item_array|
      item_array.map do |item|
        item.unit_price
      end
    end
  end

  def get_prices_from_one_merchant(merchant_id)
    merchants_with_prices.find do |merchant, prices|
      merchant.id == merchant_id
    end.last.flatten
  end

  def link_merchant_ids_with_item_ids_linked_to_quantities
    @merchant_ids_with_invoice_items.transform_values do |invoice_items|
      item_ids_with_quantities = Hash.new(0)
      invoice_items.map do |inv_item|
        if inv_item.quantity > item_ids_with_quantities[inv_item.item_id]
          item_ids_with_quantities[inv_item.item_id] = inv_item.quantity
        end
      end
      item_ids_with_quantities
    end
  end

  def link_merchant_ids_with_most_sold_item_ids
    link_merchant_ids_with_item_ids_linked_to_quantities.transform_values do |item_ids_with_qtys|
      item_ids_with_qtys.select do |item_id, qty|
        qty == item_ids_with_qtys.max_by {|ii, q| q}[1]
      end.keys
    end
  end

  def link_merchant_ids_with_most_sold_items
    link_merchant_ids_with_most_sold_item_ids.transform_values do |item_ids|
      item_ids.map {|item_id| items.find_by_id(item_id)}
    end
  end

  def link_merchant_ids_with_item_ids_linked_to_revenue
    @merchant_ids_with_invoice_items.transform_values do |invoice_items|
      item_ids_with_revenue = Hash.new(0)
      invoice_items.map do |invoice_item|
        revenue = invoice_item.unit_price * invoice_item.quantity
        item_ids_with_revenue[invoice_item.item_id] += revenue
      end
      item_ids_with_revenue
    end
  end

  def link_merchant_ids_with_best_item_ids
    link_merchant_ids_with_item_ids_linked_to_revenue.transform_values do |item_ids_with_revenue|
      item_ids_with_revenue.select do |item_id, revenue|
        revenue == item_ids_with_revenue.values.max
      end.to_a.flatten.first
    end
  end

  def link_merchant_ids_with_best_items
    link_merchant_ids_with_best_item_ids.transform_values do |item_id|
      items.find_by_id(item_id)
    end
  end

  def missing_merchant_ids
    merchant_ids = Hash.new { |hash, key| hash[key] = [] }
    invoices.all.each do |invoice|
        merchant_ids[invoice.merchant_id] = 0 if !invoice.is_paid_in_full?
      end
    merchant_ids
  end

end
