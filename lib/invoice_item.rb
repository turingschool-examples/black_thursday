require 'time'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :updated_at,
              :created_at
  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @id           = data[:id]
    @item_id      = data[:item_id]
    @invoice_id   = data[:invoice_id]
    @quantity     = data[:quantity]
    @unit_price   = data[:unit_price]
    @created_at   = Time.parse(data[:created_at]) if data[:created_at]
    @updated_at   = Time.parse(data[:updated_at]) if data[:updated_at]
  end

end
