require 'bigdecimal'

class InvoiceItem
  attr_accessor :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at

 def initialize(attributes)
   @id = attributes[:id].to_i
   @item_id = attributes[:item_id].to_i
   @invoice_id = attributes[:invoice_id].to_i
   @quantity = attributes[:quantity].to_i
   @unit_price = BigDecimal.new(attributes[:unit_price])/100
   @created_at = time_conversion(attributes[:created_at])
   @updated_at = time_conversion(attributes[:updated_at])
 end

 def time_conversion(time)
   if time.class == String
     time = Time.parse(time)
   end
   time
 end
end
