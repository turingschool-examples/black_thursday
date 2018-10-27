require_relative 'repository'
require_relative 'invoice_item'

class InvoiceItemRepository < Repository
  attr_reader :type, :attr_whitelist
  def initialize
    @type = InvoiceItem
    @attr_whitelist = [:quantity, :unit_price]
    super
  end

  def find_all_by_item_id(item_id)
    @instances.find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @instances.find_all {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

end
