# frozen_string_literal: false

require_relative 'invoice_item'
require_relative 'repository'
# Responsible for holding and searching InvoiceItem instances.
class InvoiceItemRepository
  include Repository
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
    attributes[:id] = find_highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << InvoiceItem.new(attributes)
  end

  def update(id, attributes)
    invoice_item = find_by_id(id)
    unless invoice_item.nil?
      invoice_item.quantity   = attributes[:quantity] if attributes[:quantity]
      invoice_item.updated_at = Time.now
    end
    return nil
  end

  def find_all_by_item_id(id)
    @repository.find_all do |invoice_item|
      id == invoice_item.item_id
    end
  end
end
