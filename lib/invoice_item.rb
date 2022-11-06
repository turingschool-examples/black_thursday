require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at
  attr_accessor :updated_at,
                :quantity,
                :unit_price

  def initialize(ii_input)
    
    @id           = ii_input[:id].to_i
    @item_id      = ii_input[:item_id].to_i
    @invoice_id   = ii_input[:invoice_id].to_i
    @quantity     = ii_input[:quantity].to_i
    @unit_price   = ii_input[:unit_price].to_f / 100
    @created_at   = Time.parse(ii_input[:created_at].to_s)
    @updated_at   = Time.parse(ii_input[:updated_at].to_s)
  end

  def unit_price
    BigDecimal(@unit_price,5)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end