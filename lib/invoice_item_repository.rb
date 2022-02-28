require_relative 'invoice_item'
require_relative 'module'
class InvoiceItemRepository
  include IDManager
  def initialize(all)
    @all = all
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all { |item| item.invoice_id == invoice_id}
  end
  #inspect method is required for spec harness to run
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
