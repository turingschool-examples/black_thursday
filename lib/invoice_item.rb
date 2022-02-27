require 'bigdecimal'
require 'CSV'
require 'time'


class InvoiceItem

  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @item_id = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity = attributes[:quantity].to_i
    @unit_price = BigDecimal(attributes[:unit_price])
    @created_at = attributes[:created_at].class == Time ? attributes[:created_at] : Time.parse(attributes[:created_at])
    @updated_at = attributes[:updated_at].class == Time ? attributes[:updated_at] : Time.parse(attributes[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end


end
