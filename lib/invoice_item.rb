require 'time'

class InvoiceItem
  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(info_hash)
    @id = info_hash[:id]
    @item_id = info_hash[:item_id]
    @invoice_id = info_hash[:invoice_id]
    @quantity = info_hash[:quantity]
    @unit_price = info_hash[:unit_price]
    @created_at = info_hash[:created_at]
    @updated_at = info_hash[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    # attributes[:updated_at] = Time.now
    @quantity = attributes[:quantity] || @quantity
    @unit_price = attributes[:unit_price] || @unit_price
    @updated_at = attributes[:updated_at]
  end
end
