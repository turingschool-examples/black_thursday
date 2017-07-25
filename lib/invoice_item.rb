require 'bigdecimal'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at, :unit_price_to_dollars

  def initialize(invoice_hash)
    @id = invoice_hash[:id].to_i
    @item_id = invoice_hash[:item_id]
    @invoice_id = invoice_hash[:invoice_id]
    @quantity = invoice_hash[:quantity]
    @unit_price = BigDecimal.new(invoice_hash[:unit_price])
    @created_at = invoice_hash[:created_at]
    @updated_at = invoice_hash[:updated_at]
    @unit_price_to_dollars = unit_price.to_f
  end

  # The invoice item has the following data accessible:

  # id - returns the integer id
  # item_id - returns the item id
  # invoice_id - returns the invoice id
  # quantity - returns the quantity
  # unit_price - returns the unit_price
  # created_at - returns a Time instance for the date the invoice item was first created
  # updated_at - returns a Time instance for the date the invoice item was last modified
  # It also offers the following method:
  #
  # unit_price_to_dollars - returns the price of the invoice item in dollars formatted as a Float


end
