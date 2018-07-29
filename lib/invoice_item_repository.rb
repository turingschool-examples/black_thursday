require_relative 'invoice_item'
require_relative 'repo_methods'

class InvoiceItemRepository
  include RepoMethods

  def initialize(invoice_item_data)
    @invoice_rows ||= build_invoice(invoice_item_data)
    @repo = @invoice_rows
  end

  def build_invoice(invoice_item_data)
    invoice_item_data.map do |invoice_item|
      InvoiceItem.new(invoice_item)
    end
  end

  def find_all_by_item_id(item_id)
    @repo.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def create(attributes)
    id = create_id
    invoice_item = InvoiceItem.new(
      id: id,
      item_id: attributes[:item_id],
      invoice_id: attributes[:invoice_id],
      quantity: attributes[:quantity],
      unit_price: attributes[:unit_price],
      created_at: Time.now,
      updated_at: Time.now
      )
    @repo << invoice_item
    invoice_item
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return if invoice.nil?
    invoice.quantity = attributes[:quantity]
    invoice.unit_price = attributes[:unit_price]
    invoice.updated_at = Time.now
    invoice
  end
end
