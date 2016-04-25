require 'pry'
require 'bigdecimal'
require 'time'

class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
              :created_at, :updated_at, :invoice_item_repository

  def initialize(column, parent = nil)
    @id = column[:id].to_i
    @item_id = column[:item_id].to_i
    @invoice_id = column[:invoice_id].to_i
    @quantity = column[:quantity].to_i
    @unit_price = BigDecimal.new(column[:unit_price].to_i)/BigDecimal(100)
    @created_at = Time.parse(column[:created_at])
    @updated_at = Time.parse(column[:updated_at])
    @invoice_item_repository = parent
  end

  def unit_price_in_dollars
    dollar_price = sprintf('%.02f', unit_price).to_f
  end

end
