require 'bigdecimal'

class InvoiceItem

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price

  def initialize(invoice_item_data)
    @id = invoice_item_data[:id].to_i
    @item_id = invoice_item_data[:item_id].to_i
    @invoice_id = invoice_item_data[:invoice_id].to_i
    @quantity = invoice_item_data[:quantity].to_i
    @unit_price = BigDecimal.new(invoice_item_data[:unit_price].to_i)/100
    
  end

end
