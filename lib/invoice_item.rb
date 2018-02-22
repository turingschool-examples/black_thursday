require 'bigdecimal'
require 'time'
class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id = data[:id].to_i
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price  = BigDecimal.new(data[:unit_price], 4)/100
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @parent = parent
  end

  def unit_price_to_dollars
    (@unit_price.to_f)
  end

  # def merchant
  #   @parent.item_repo_goes_to_sales_engine_with_merchant_id(self.merchant_id)
  # end
end
