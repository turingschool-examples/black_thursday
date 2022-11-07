require 'bigdecimal'

class  InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info, repo)
    @id         = info[:id]
    @item_id    = info[:item_id]
    @invoice_id = info[:invoice_id]
    @quantity    = info[:quantity]
    @unit_price = info[:unit_price]
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @repo       = repo
  end
  def update(info)
    @updated_at = Time.now
  end
end