require_relative 'invoice_repository'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at

  def initialize(invoice_data, parent = nil)
    @invoice_parent = parent
    @id             = invoice_data[:id].to_i
    @customer_id    = invoice_data[:customer_id].to_i
    @merchant_id    = invoice_data[:merchant_id].to_i
    @status         = invoice_data[:status].to_sym
    @created_at  = determine_the_time(invoice_data[:created_at])
    @updated_at  = determine_the_time(invoice_data[:updated_at])
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

end