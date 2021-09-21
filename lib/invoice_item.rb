require 'time'

class InvoiceItem

  attr_reader   :id,
                :item_id,
                :invoice_id,
                :created_at,
                :quantity,
                :unit_price,
                :updated_at

  def initialize(data)
    @id           = data[:id].to_i
    @item_id      = data[:item_id].to_i
    @invoice_id   = data[:invoice_id].to_i
    @quantity     = data[:quantity].to_i
    @unit_price   = BigDecimal(data[:unit_price]) / 100
    @created_at   = Time.parse(data[:created_at])
    @updated_at   = Time.parse(data[:updated_at])
  end

  def unit_price_to_dollars
    "$" + @unit_price.to_s
  end

  def update_quantity(quantity)
    @quantity = quantity
  end

  def update_unit_price(up)
    @unit_price = up
  end

  def update_updated_at
    @updated_at = Time.now
  end
end
