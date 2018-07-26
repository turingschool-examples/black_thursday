require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class InvoiceItemRepository
  include Repository

  def initialize(invoice_items)
    @list = invoice_items
  end

  def create(attributes)
    highest_invoice_item_id = find_highest_id
    attributes[:id] = highest_invoice_item_id.id + 1
    @list << InvoiceItem.new(attributes)
  end
end
