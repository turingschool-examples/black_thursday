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
      invoice_items = @invoice_items.find_all_by_item_id(business_data.id)
      invoice_ids = invoice_items.map(&:invoice_id)
      @invoices.all.select{ |invoice| invoice_ids.include?(invoice.id)}
      #could refactor above 3 lines into 1 if there was a find_invoices_from_array method
    when 'Invoice'
      [business_data]
    end
  end

  def revenue_from_invoice(invoice)
    return 0 unless @transactions.find_all_by_invoice_id(invoice_id).any?{|tr| tr.result == :success}
    invoice_items = @invoice_items.find_all_by_invoice_id(invoice.id)
    return 0 if invoice_items.empty?
    invoice_items.flatten.map(&:revenue)
  end
end
