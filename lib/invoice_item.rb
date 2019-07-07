class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id].to_i
    @item_id = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity = invoice_item_data[:quantity].to_i
    @unit_price = BigDecimal(invoice_item_data[:unit_price]) / 100
    @created_at = Time.parse(invoice_item_data[:created_at].to_s)
    @updated_at= Time.parse(invoice_item_data[:updated_at].to_s)
  end
end
