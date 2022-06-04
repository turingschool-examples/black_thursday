require 'helper'

class Invoice
  attr_reader :id,
              :merchant_id,
              :customer_id,
              :status,
              :created_at,
              :updated_at

  def initialize(input)
    @id = input[:id]
    @merchant_id = input[:merchant_id]
    @customer_id = input[:customer_id]
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end
end
