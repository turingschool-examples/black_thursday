require 'helper'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(input)
    @id = input[:id].to_i
    @customer_id = input[:customer_id].to_i
    @merchant_id = input[:merchant_id].to_i
    @status = input[:status].to_sym
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end
end
