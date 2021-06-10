class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :repo

  def initialize(info, repo)
    @id = info[:id].to_i
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity].to_i
    @unit_price = (BigDecimal(info[:unit_price], 4) / 100)
    @created_at = info[:created_at].is_a?(Time) ? info[:created_at] : Time.parse(info[:created_at])
    @updated_at = info[:updated_at].is_a?(Time) ? info[:updated_at] : Time.parse(info[:updated_at])
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_invoice_item(attributes)
    @quantity = attributes[:quantity] unless attributes[:quantity].nil?
    @unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    @updated_at = Time.now
  end
end
