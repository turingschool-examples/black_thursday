module Finders

  def find_invoices_from(business_data)
    class_string = business_data.class.to_s
    case class_string
    when 'Merchant', 'Customer'
      method_name = "find_all_by_#{class_string.downcase}_id"
      @invoices.public_send(method_name, business_data.id)
    when 'InvoiceItem', 'Transaction'
      [@invoices.find_by_id(business_data.invoice_id)]
    when 'Item'
      # find_invoices_from()
    when 'Invoice'
      [business_data]
    end
  end

  def related_array_get(var, merch_ids)
    case var
    when :@merchants
      instance_variable_get(var).all.select{|instance| merch_ids.include?(instance.id)}
    when :@invoice_items
      invoice_ids = @invoices.all.select{|iv| merch_ids.include?(iv.merchant_id)}.map(&:id)
      @invoice_items.all.select{|iv_items| invoice_ids.include?(iv_items.invoice_id)}
    when :@customers
      customer_ids = @invoices.all.select{|iv| merch_ids.include?(iv.merchant_id)}.map(&:customer_id).uniq
      @customers.all.select{ |customer| customer_ids.include?(customer.id)}
    when :@transactions
      #exact same pattern as when :@invoice_items
      invoice_ids = @invoices.all.select{|iv| merch_ids.include?(iv.merchant_id)}.map(&:id)
      @transactions.all.select{ |transaction| invoice_ids.include?(transaction.invoice_id)}
    else
      instance_variable_get(var).all.select{|instance| merch_ids.include?(instance.merchant_id)}
    end
  end

  def to_arr_of_hashes(arr_of_objects)
    arr_of_objects.reduce([]) do |arr, ob|
      arr << to_h(ob)
    end
  end
  def to_h(object)
    new_hash = {}
    object.instance_variables.each do |var|
      new_hash[var.to_s.delete("@")] = object.instance_variable_get(var)
    end
    new_hash
  end
end
