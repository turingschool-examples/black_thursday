require_relative "../lib/item_data_access"
class InvoiceItem
  include ItemDataAccess
  attr_reader :id,
              :item_id,
              :invoice_id,
              :unit_price,
              :quantity,
              :created_at, 
              :updated_at,
              :parent

  def initialize(data, parent=nil)
    @id  = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price =  data[:unit_price]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
  end
end
