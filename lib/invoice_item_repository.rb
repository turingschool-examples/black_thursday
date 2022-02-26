require_relative 'invoice_item'

class InvoiceItemRepository
  def initialize(all)
    @all = all
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all { |item| item.invoice_id == invoice_id}
  end
end
