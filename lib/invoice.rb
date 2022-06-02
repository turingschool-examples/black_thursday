require 'helper'

class Invoice
  attr_reader :id,
              :created_at,
              :updated_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price

  def initialize(input)
    @id = input[:id]
    @merchant_id = input[:merchant_id]
    @customer_id = input[:customer_id]
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  # def unit_price_to_dollars
  #   @unit_price.to_f
  # end

end
