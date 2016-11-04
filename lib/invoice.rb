require_relative './time_formatter'

class Invoice
  include TimeFormatter
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice_data, parent = nil)
    @id          = invoice_data[:id]
    @customer_id = invoice_data[:customer_id]
    @merchant_id = invoice_data[:merchant_id]
    @status      = invoice_data[:status]
    @created_at  = format_time(invoice_data[:created_at].to_s)
    @updated_at  = format_time(invoice_data[:updated_at].to_s)
    @parent      = parent
  end
end
