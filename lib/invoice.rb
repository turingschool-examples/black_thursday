require 'time'

class Invoice
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
    @status = invoice_data[:status]
    @created_at = time_converter(invoice_data[:created_at])
    @updated_at = time_converter(invoice_data[:updated_at])
  end

  def time_converter(arguement)
    if arguement.class == String
      Time.parse(arguement)
    else
      arguement
    end
  end

end
