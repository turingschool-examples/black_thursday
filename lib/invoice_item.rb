require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at,
                :parent

  def initialize(invoice_item_hash, parent=nil)
    @id = invoice_item_hash[:id].to_i
    @item_id = invoice_item_hash[:item_id].to_i
    @invoice_id = invoice_item_hash[:invoice_id].to_i
    @quantity = invoice_item_hash[:quantity].to_i
    @unit_price = BigDecimal(format_unit_price(invoice_item_hash[:unit_price]))
    @created_at = Time.parse(invoice_item_hash[:created_at])
    @updated_at = Time.parse(invoice_item_hash[:updated_at])
    @parent = parent
  end

  def format_unit_price(price)
    price.chars.insert(-3, ".").join
  end

end