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
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_sym
    @created_at = return_time_from(invoice_data[:created_at])
    @updated_at = return_time_from(invoice_data[:updated_at])
  end
end
