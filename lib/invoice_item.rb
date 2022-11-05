require 'bigdecimal'

class  InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quanity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(info, repo)
    @id         = info[:id]
    @item_id    = info[:item_id]
    @invoice_id = info[:invoice_id]
    @quanity    = info[:quanity]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @repo       = repo
  end
end