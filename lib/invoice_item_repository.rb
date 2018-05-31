require_relative 'invoice_item'
require_relative 'repository'

class InvoiceItemRepository
  include Repository
  # Responsible for holding and searching InvoiceItem instances.
  attr_reader :invoice_items

  def initialize(invoice_items)
    @invoice_items = invoice_items
    @repository = []
    create_all_invoice_items
  end

  def create_all_invoice_items
    @invoice_items.each do |invoice_item|
      @repository << InvoiceItem.new(invoice_item)
    end
  end

  def create(attributes)
    highest_id = @repository.max_by { |invoice_item| invoice_item.id }
    attributes[:id] = highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << InvoiceItem.new(attributes)
  end

  def find_all_by_item_id(id)
    @repository.find_all do |element|
      id == element.item_id
    end
  end

  def find_all_by_invoice_id(id)
    @repository.find_all do |element|
      id == element.invoice_id
    end
  end


end
