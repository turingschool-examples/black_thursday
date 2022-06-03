require 'helper'

class Invoice
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at,
              :customer_id,
              :status

  def initialize(input)
    @id = input[:id].to_i
    @item_id = input[:item_id].to_i
    @invoice_id = input[:invoice_id].to_i
    @quantity = input[:quantity].to_i
    @unit_price = input[:unit_price]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
    @customer_id = input[:customer_id]
    @status = input[:status]
  end
end
