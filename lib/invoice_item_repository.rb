# frozen_string_literal: true

require_relative 'invoice_item.rb'

# This class holds how invoices are connected to items
class InvoiceItemRepository
  attr_reader :repository
              :parent

  def initialize(invoice_items, parent)
    @repository = invoice_items.map { |invoice_item| InvoiceItem.new(invoice_item, self)}
    @parent = parent
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items = @repository.find_all do |invoice_item|
      invoice_item.item_id == item_id
    end
    return [] if invoice_items.nil?
    invoice_items
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items = @repository.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
    return [] if invoice_items.nil?
    invoice_items
  end

  def create(attributes)
    id_array = @repository.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @repository << InvoiceItem.new(attributes, self)
  end
end
