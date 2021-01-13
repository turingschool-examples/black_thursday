class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at,
              :invoice_items_repo,
              :unit_price_to_dollars

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(data, invoice_items_repo)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity]
    @unit_price = BigDecimal(data[:unit_price]) / 100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @invoice_items_repo = invoice_items_repo
    @unit_price_to_dollars = unit_price.to_f
  end
end
