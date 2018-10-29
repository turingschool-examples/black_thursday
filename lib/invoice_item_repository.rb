require_relative './repository'
require_relative './invoice_item'

class InvoiceItemRepository < Repository

  def new_record(row)
    InvoiceItem.new(row)
  end

  def find_all_by_item_id(item_id)
    all.find_all do |item|
      item.item_id == item_id
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repo_array << new_invoice_item = InvoiceItem.new(attributes)
    new_invoice_item
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    return invoice_item if invoice_item.nil?
    invoice_item.quantity = attributes[:quantity] unless attributes[:quantity].nil?
    invoice_item.unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    invoice_item.updated_at = Time.now
  end

end
