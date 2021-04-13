require_relative './time_convert_module'

class Invoice

  attr_accessor :status,
                :updated_at
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at

  include TimeConvert

  def initialize(invoice_data)
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_sym
    @created_at = time_converter(invoice_data[:created_at])
    @updated_at = time_converter(invoice_data[:updated_at])
  end

end
