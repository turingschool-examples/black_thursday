require 'bigdecimal'
require 'time'

class InvoiceItem

  attr_reader   :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

  def initialize(params = {}, parent = nil)
    @parent     = parent
    @id         = params["id"].to_i
    @item_id    = params["item_id"].to_i
    @invoice_id = params["invoice_id"].to_i
    @quantity   = params["quantity"].to_i
    @unit_price = BigDecimal.new(params["unit_price"])/100
    @created_at = Time.parse(params["created_at"])
    @updated_at = Time.parse(params["updated_at"])
  end


end
