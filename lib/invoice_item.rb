require 'requirements'

class  InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info, repo)
    @id         = info[:id].to_i
    @item_id    = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity   = info[:quantity].to_i
    @unit_price = BigDecimal((info[:unit_price].to_f / 100), 5)
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @repo       = repo
  end

  def unit_price_to_dollars
    @unit_price.round(2).to_f
  end

  def update(attributes)
    @quantity   = attributes[:quantity]
    @updated_at = Time.now
  end
end