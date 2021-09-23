# frozen_string_literal: true

# this is the Invoice Item class for Black Thursday

require 'BigDecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :created_at,
              :unit_price,
              :updated_at

  def initialize(invoice_item)
    @id = invoice_item[:id].to_i
    @item_id = invoice_item[:item_id].to_i
    @invoice_id = invoice_item[:invoice_id].to_i
    @quantity = invoice_item[:quantity].to_f
    @unit_price = BigDecimal(invoice_item[:unit_price].to_i) / 100
    @created_at = Time.parse(invoice_item[:created_at])
    @updated_at = Time.parse(invoice_item[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_s
  end

  def update(attributes)
    @updated_at = Time.now
    attributes.each do |key, value|
      @quantity = value if key == :quantity
      @unit_price = value if key == :unit_price
    end
    self
  end
end
