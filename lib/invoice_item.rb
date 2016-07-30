require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :parent
  
  def initialize(invoice_item_details, repo = nil)
    @id         = invoice_item_details[:id].to_i 
    @item_id    = invoice_item_details[:item_id].to_i 
    @invoice_id = invoice_item_details[:invoice_id].to_i
    @quantity   = invoice_item_details[:quantity].to_i
    @unit_price = BigDecimal(invoice_item_details[:unit_price].to_f, 4)
    @created_at = format_time(invoice_item_details[:created_at].to_s)
    @updated_at = format_time(invoice_item_details[:updated_at].to_s)
    @parent     = repo
  end
  
  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end
  
  def unit_price_to_dollars
    @unit_price/100.0
  end
  
end