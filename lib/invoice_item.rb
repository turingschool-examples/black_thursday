require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :invoice_item_repo

  def initialize(info = {}, invoice_item_repository = "")
    @id = info[:id].to_i
    @item_id = info[:item_id].to_i
    @invoice_id = info[:invoice_id].to_i
    @quantity = info[:quantity].to_i
    @unit_price = BigDecimal.new(info[:unit_price].to_f/100, 6)
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @invoice_item_repo = invoice_item_repository
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
