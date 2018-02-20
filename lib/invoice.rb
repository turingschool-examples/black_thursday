require_relative 'searching'
require 'Time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at

  
  def initialize(sales_data)
    @id          = sales_data[:id]
    @customer_id = sales_data[:customer_id]
    @merchant_id = sales_data[:merchant_id]
    @status      = sales_data[:status]
    @created_at  = sales_data[:created_at] 
  end

end