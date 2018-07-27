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

  def update(id, attributes)
    if find_by_id(id)
      if attributes[:quantity]
        find_by_id(id).quantity = attributes[:quantity]
      end
      if attributes[:unit_price]
        find_by_id(id).unit_price = attributes[:unit_price]
      end
      find_by_id(id).updated_at = Time.now
    end
  end
end
