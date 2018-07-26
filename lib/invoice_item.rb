require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :unit_price,
                :quantity,
                :created_at


  attr_accessor :updated_at

  def initialize(invoice_item_hash)
    @id = invoice_item_hash[:id].to_i
    @item_id = invoice_item_hash[:item_id].to_i
    @invoice_id = invoice_item_hash[:invoice_id].to_i
    @quantity = invoice_item_hash[:quantity]
    @unit_price = BigDecimal(invoice_item_hash[:unit_price].to_i) / 100
    @created_at = Time.parse(invoice_item_hash[:created_at])
    @updated_at = Time.parse(invoice_item_hash[:updated_at])
  end

end
