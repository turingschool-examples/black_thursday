require_relative 'make_time'

class Invoice 
  include MakeTime 

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice_data)
    @id = invoice_data[:id]
    @customer_id = invoice_data[:customer_id]
    @merchant_id = invoice_data[:merchant_id]
    @status = invoice_data[:status]
    @created_at = return_time_from(invoice_data[:created_at])
    @updated_at = return_time_from(invoice_data[:updated_at])
  end
end