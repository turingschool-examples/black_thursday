# invoice_item_repository
require 'pry'



class InvoiceItemsRepository
  attr_reader :invoice_items

  def initialize(invoice_items)
    @invoice_items = invoice_items
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    # require "pry"; binding.pry
    @invoice_items.find { |invoice| invoice.id == id }
  end

  def find_all_by_item_id(item_id)
    @invoice_items.find_all { |item| item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id }
  end

  def create(attributes)
    @invoice_items.sort_by { |invoice_item| invoice_item.id }
    last_id = @invoice_items.last.id
    attributes[:id] = (last_id += 1)
    @invoice_items << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    attributes.map do |key, value|
        invoice_item.quantity = value if key == :quantity
        invoice_item.unit_price = value if key == :unit_price
        invoice_item.updated_at = Time.now
    end
  end

end
