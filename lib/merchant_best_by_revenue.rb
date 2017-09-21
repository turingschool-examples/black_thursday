module MerchantBestByRevenue

  def valid_merchant_invoices(merchant_id)
    invoice_instance_array = []
     sales_engine.invoices.find_all_by_merchant_id(merchant_id).select do |invoice|
      invoice_instance_array << invoice if invoice.is_paid_in_full?
    end
    invoice_instance_array    #returns invoice instances
  end

  #get valid invoices, strip invoice id. - DONE
  def get_invoice_id(merchant_id)
    valid_merchant_invoices(merchant_id).map do |invoice|
      invoice.id
    end
  end #returns array of invoice IDs

  def all_invoice_items(merchant_id)
    get_invoice_id(merchant_id).map do |invoice_id|
      sales_engine.invoice_items.find_all_by_invoice_id(invoice_id).flatten
    end
  end

  def item_ids_and_total(merchant_id)
    hash = Hash.new
    all_invoice_items(merchant_id).flatten.each do |item_instance|
      temp_hash = {item_instance.item_id => item_instance.quantity * item_instance.unit_price}
      hash.merge!(temp_hash) { |k,v, new_v| v + new_v  }
    end
    hash
  end

  def highest_value_item(merchant_id)
    highest_revenue = item_ids_and_total(merchant_id).values.max
    item_ids_and_total(merchant_id).key(highest_revenue)
  end





end
