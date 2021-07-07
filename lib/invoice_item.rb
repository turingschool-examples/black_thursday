# This is the invoice item class.
class InvoiceItem
  attr_reader :parent,
              :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @parent      = parent
    @id          = data[:id].to_i
    @item_id     = data[:item_id].to_i
    @invoice_id  = data[:invoice_id].to_i
    initialize_remaining_attributes(data)
  end

  def initialize_remaining_attributes(data)
    @quantity    = data[:quantity].to_i
    @unit_price  = BigDecimal.new(data[:unit_price].to_i) / 100
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
