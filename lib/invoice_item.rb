# frozen_string_literal: true

require 'bigdecimal'
require 'date'
require 'time'

# Processes invoices for individual items
class InvoiceItem

  def initialize(invoice_items, parent)
    @invoice_items_specs = {
      id: invoice_items[:id].to_i,
      item_id: ',
      invoice_id:,
      quantity: ,
      unit_price: ,
      created_at: ,
      updated_at:
    }
  end
end
