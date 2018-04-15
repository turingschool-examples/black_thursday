require_relative 'elementals'

# invoice_item class
class InvoiceItem
  include Elementals

  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(attrs)
    sigdigits    = attrs[:unit_price].to_s.length - 1
    @id          = attrs[:id].to_i
    @item_id     = attrs[:item_id].to_i
    @invoice_id  = attrs[:invoice_id].to_i
    @quantity    = attrs[:quantity].to_i
    @unit_price  = BigDecimal(attrs[:unit_price], sigdigits) / 100
    @created_at  = format_time(attrs[:created_at])
    @updated_at  = format_time(attrs[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price = @unit_price.to_f.round(2)
  end
end
