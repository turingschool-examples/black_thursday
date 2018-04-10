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
end
