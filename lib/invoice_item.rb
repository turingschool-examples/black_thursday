require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
              :created_at, :updated_at, :unit_price_to_dollars,
              :invoice_item_repo

  def initialize(invoice_item_hash, invoice_item_repo)
    @id                    = invoice_item_hash[:id].to_i
    @item_id               = invoice_item_hash[:item_id].to_i
    @invoice_id            = invoice_item_hash[:invoice_id].to_i
    @quantity              = invoice_item_hash[:quantity]
    @price                 = BigDecimal.new(invoice_item_hash[:unit_price])
    @unit_price            = price_create(@price)
    @created_at            = Time.parse(invoice_item_hash[:created_at])
    @updated_at            = Time.parse(invoice_item_hash[:updated_at])
    @unit_price_to_dollars = unit_price.to_f
    @invoice_item_repo     = invoice_item_repo
  end

  def price_create(price)
    price/100
  end


end
