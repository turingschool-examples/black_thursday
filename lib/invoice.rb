require_relative 'searching'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  
  def initialize(sales_data)
    @id          = sales_data[:id]
    @customer_id = sales_data[:customer_id]
    @merchant_id = sales_data[:merchant_id]
    @status      = sales_data[:status]
    @created_at  = sales_data[:created_at]
    @updated_at  = sales_data[:updated_at] 
  end

end