# frozen_string_literal: true

require 'bigdecimal'
require 'date'
require 'time'

# Processes invoices for individual items
class InvoiceItem
  attr_reader :invoice_item_specs,
              :parent

  def initialize(invoice_items, parent)
    @invoice_items_specs = {
      id:                     invoice_items[:id].to_i,
      item_id:                invoice_items[:item_id].to_i,
      invoice_id:             invoice_items[:invoice_id].to_i,
      quantity:               invoice_items[:quantity].to_i,
      unit_price:             BigDecimal(invoice_items[:unit_price]) / 100,
      created_at:             invoice_items[:created_at],
      updated_at:             invoice_items[:updated_at]
    }
    @parent = parent
  end
end
