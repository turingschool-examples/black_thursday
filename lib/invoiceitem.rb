# invoice_item class
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(invoice_item_hash = Hash.new(0))
    sigdigits    = invoice_item_hash[:unit_price].to_s.length - 1
    @id          = invoice_item_hash[:id].to_i
    @item_id     = invoice_item_hash[:item_id].to_i
    @invoice_id  = invoice_item_hash[:invoice_id].to_i
    @quantity    = invoice_item_hash[:quantity].to_i
    @unit_price  = BigDecimal(invoice_item_hash[:unit_price], sigdigits) / 100
    @created_at  = invoice_item_hash[:created_at]
    @updated_at  = invoice_item_hash[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price = @unit_price.to_f.round(2)
  end
end
