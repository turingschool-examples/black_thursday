class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(invoice_items, invoice_items_repo)
    @invoice_items  = invoice_items
    @id             = invoice_items[:id].to_i
    @item_id        = invoice_items[:item_id].to_i
    @invoice_id     = invoice_items[:invoice_id].to_i
    @quantity       = invoice_items[:quantity].to_i
    @unit_price     = unit_price_to_dollars
    @created_at     = Time.parse(invoice_items[:created_at].to_s)
    @updated_at     = Time.parse(invoice_items[:updated_at].to_s)
  end

  def unit_price_to_dollars
    var = BigDecimal.new(@invoice_items[:unit_price])
    var/100
  end


end
