require_relative '../lib/invoice_item'
require_relative '../lib/repository'
require 'bigdecimal/util'

class InvoiceItemRepository < Repository

  def initialize(path)
    super(path, InvoiceItem)
    # @array_of_objects = create_objects(@parsed_csv_data)
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

  def create(attributes)
    max_id = @array_of_objects.max_by do |invoice_item|
      invoice_item.id
    end.id
    new_invoice_item = InvoiceItem.new(attributes)
    new_invoice_item.id = max_id + 1
    @array_of_objects << new_invoice_item
  end

  def update(id, attributes)
    target = find_by_id(id)
    if target != nil
      target.quantity = attributes[:quantity] if attributes[:quantity] != nil
      target.updated_at = Time.now
    end
  end
end
