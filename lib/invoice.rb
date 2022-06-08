require_relative 'helper'

class Invoice
  attr_reader :id,
              :merchant_id,
              :customer_id,
              :status,
              :created_at

  attr_accessor :updated_at,
                :status

  def initialize(input)
    @id = input[:id].to_i
    @customer_id = input[:customer_id].to_i
    @merchant_id = input[:merchant_id].to_i
    # status needs to be changed to a symbol in the
    # analyst class 'invoice_status' method, not here
    # or it breaks tests
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end
end
