require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id,
              :quantity,
              :created_at,
              :updated_at,
              :unit_price,
              :parent,
              :invoice_id,
              :item_id,
              :price

  def initialize(invoice_item_info = nil, repo = nil)
    return if invoice_item_info.to_h.empty?
    @parent     = repo
    @id         = invoice_item_info[:id].to_i
    @item_id    = invoice_item_info[:item_id].to_i
    @invoice_id = invoice_item_info[:invoice_id].to_i
    @quantity   = invoice_item_info[:quantity].to_i
    @created_at = Time.parse(invoice_item_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_item_info[:updated_at].to_s)
    @price      = unit_price_to_dollars(invoice_item_info[:unit_price].to_s)
    @unit_price = BigDecimal.new(@price, @price.to_s.length - 1)
  end

  def unit_price_to_dollars(price)
    price.to_i / 100.0
  end

  def invoice
    parent.find_invoice_by_id(invoice_id)
  end

  def item
    parent.find_item_by_id(item_id)
  end

end
