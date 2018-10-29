module Finders

  def find_type_from_object(type, object)
    invoices = find_invoices_from(object)
    find_from_invoices(invoices, type)
  end

  def find_invoices_from(business_data)
    class_string = business_data.class.to_s
    case class_string
    when 'Merchant', 'Customer'
      method_name = "find_all_by_#{class_string.downcase}_id"
      @invoices.public_send(method_name, business_data.id)
    when 'InvoiceItem', 'Transaction'
      [@invoices.find_by_id(business_data.invoice_id)]
    when 'Item'
      invoice_items = @invoice_items.find_all_by_item_id(business_data.id)
      invoice_ids = invoice_items.map(&:invoice_id)
      @invoices.all.select{ |invoice| invoice_ids.include?(invoice.id)}
      #could refactor above 3 lines into 1 if there was a find_invoices_from_array method
    when 'Invoice'
      [business_data]
    end
  end

  def find_from_invoices(invoices, class_string)
    invoices.compact.reduce([]) do |rslt, invoice|
      rslt += find_from_invoice(invoice, class_string)
    end
  end

  def find_from_invoice(invoice, class_string)
    repository = get_repository(class_string)
    case class_string
    when 'InvoiceItem', 'Transaction'
      repository.all.select {|iv_item| iv_item.invoice_id == invoice.id}
    when 'Merchant', 'Customer'
      method_name = "#{class_string.downcase}_id"
      [repository.find_by_id(invoice.public_send(method_name))]
    when 'Item'
      item_ids = find_from_invoice(invoice, 'InvoiceItem').map(&:item_id).uniq
      item_ids.collect { |item_id| repository.find_by_id(item_id) }
    when 'Invoice'
      [invoice]
    end
  end

  def get_repository(class_string)
    repository = underscore("@#{class_string}s")
    instance_variable_get(repository)
  end

  def underscore(string)
    string.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    downcase
  end

  def revenue_from_invoice(invoice)
    return 0 unless @transactions.any_success?(invoice.id)
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
    return 0 if invoice_items.empty?
    invoice_items.flatten.map(&:revenue).reduce(&:+)
  end

  def revenue_from_invoices(invoices)
    amounts = invoices.reduce([]) do |arr, invoice|
      arr << revenue_from_invoice(invoice)
    end
    result = amounts.reduce(&:+)
    result ? result : 0
  end
end
