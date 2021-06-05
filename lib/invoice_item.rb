class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repo

  def initialize(item, repo)
    @id = item[:id]
    @item_id = item[:item_id]
    @invoice_id = item[:invoice_id]
    @quantity = item[:quantity]
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @repo = repo
  end
end
