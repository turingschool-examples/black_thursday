# frozen_string_literal: true

require 'bigdecimal'
require 'date'
require 'time'

# Processes invoices for individual items
class InvoiceItem
  attr_reader :invoice_items_specs,
              :parent

  def initialize(invoice_items, parent)
    @invoice_items_specs = {
      id:                     invoice_items[:id].to_i,
      item_id:                invoice_items[:item_id].to_i,
      invoice_id:             invoice_items[:invoice_id].to_i,
      quantity:               invoice_items[:quantity].to_i,
      unit_price:             BigDecimal(invoice_items[:unit_price]) / 100,
      created_at:             Time.parse(invoice_items[:created_at].to_s),
      updated_at:             Time.parse(invoice_items[:updated_at].to_s)
    }
    @parent = parent
  end

  def id
    invoice_items_specs[:id]
  end

  def item_id
    invoice_items_specs[:item_id]
  end

  def invoice_id
    invoice_items_specs[:invoice_id]
  end

  def quantity
    invoice_items_specs[:quantity]
  end

  def unit_price
    invoice_items_specs[:unit_price]
  end

  def created_at
    invoice_items_specs[:created_at]
  end

  def updated_at
    invoice_items_specs[:updated_at]
  end

  def unit_price_to_dollars
    invoice_items_specs[:unit_price]
  end
end
