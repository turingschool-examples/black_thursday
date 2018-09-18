require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id

  attr_accessor :quantity,
                :unit_price,
                :updated_at,
                :created_at

  def initialize(hash)
   
    @id         = hash[:id].to_i
    @item_id    = hash[:item_id].to_i
    @invoice_id = hash[:invoice_id].to_i
    
    @quantity   = hash[:quantity].to_i
    @unit_price = BigDecimal.new(hash[:unit_price], 4)
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
   
  end

end
