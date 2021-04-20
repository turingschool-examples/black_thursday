require_relative '../lib/invoice_item'
require_relative '../lib/repository'
require 'bigdecimal/util'

class InvoiceItemRepository < Repository

  def initialize(path)
    super(path, InvoiceItem)
  end

  def find_all_by_item_id(item_id)
    @array_of_objects.find_all do |item|
      item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @array_of_objects.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end

  def update(id, attributes)
    target = find_by_id(id)
    if target != nil
      target.quantity = attributes[:quantity] if attributes[:quantity] != nil
      target.updated_at = Time.now
    end
  end
end
