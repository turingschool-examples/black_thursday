require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository

  def record_class
    Invoice
  end

  def find_all_by_item_id(item_id)
    find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_merchant_id(invoice_id)
    find_all {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

end
