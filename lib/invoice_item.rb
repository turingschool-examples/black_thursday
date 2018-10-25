require_relative 'business_data'

class InvoiceItem < BusinessData
  attr_reader :id, :item_id, :invoice_id, :created_at
  attr_accessor :quantity, :unit_price, :updated_at
  def initialize(input_hash)
    @id = input_hash[:id]
    @item_id = input_hash[:item_id]
    @invoice_id = input_hash[:invoice_id]
    @quantity = input_hash[:quantity]
    @unit_price = input_hash[:unit_price]
    @created_at = input_hash[:created_at]
    @updated_at = input_hash[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f.round(2)
  end
end
