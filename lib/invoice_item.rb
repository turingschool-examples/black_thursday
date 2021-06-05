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
    @id = item[:id].to_i
    @item_id = item[:item_id].to_i
    @invoice_id = item[:invoice_id].to_i
    @quantity = item[:quantity].to_i
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
