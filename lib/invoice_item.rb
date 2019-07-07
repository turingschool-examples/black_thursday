require 'time'
require 'bigdecimal'

class InvoiceItem 
  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at
              
  def initialize(hash)
    @id = hash[:id].to_i
    @item_id = hash[:item_id].to_i
    @invoice_id = hash[:invoice_id].to_i 
    @quantity = hash[:quantity].to_i 
    @unit_price = BigDecimal(hash[:unit_price].to_i)
    @created_at = if hash[:created_at].class == String
                  Time.parse(hash[:created_at])
                    else
                      Time.now
                  end
    @updated_at = if hash[:updated_at].class == String
                    Time.parse(hash[:updated_at])
                    else
                      Time.now
                  end
  end
  
  def unit_price
    @unit_price / 100
  end

  def unit_price_to_dollars
    @unit_price.to_f / 100
  end
  
end