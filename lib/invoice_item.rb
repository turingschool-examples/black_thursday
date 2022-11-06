require 'bigdecimal'

class InvoiceItem
  attr_reader :item_id,
              :invoice_id

  attr_accessor :id,
                :created_at,
                :quantity,
                :updated_at,
                :unit_price

  def initialize(attributes, repo = nil)
    @id         = attributes[:id].to_i
    @item_id    = attributes[:item_id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @quantity   = attributes[:quantity].to_i
    @unit_price = BigDecimal(attributes[:unit_price], 4) / 100
    @created_at = time_converter(attributes[:created_at])
    @updated_at = time_converter(attributes[:updated_at])
    @repo       = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def time_converter(attributes)
    return unless attributes
    Time.parse(attributes)
  end
end
