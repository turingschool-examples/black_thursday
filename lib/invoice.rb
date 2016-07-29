class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  
  def initialize(invoice_details, repo = nil)
    @id = invoice_details[:id].to_i
    @customer_id = invoice_details[:customer_id].to_i
    @merchant_id = invoice_details[:merchant_id].to_i
    @status = invoice_details[:status]
    @created_at = format_time(invoice_details[:created_at].to_s)
    @updated_at = format_time(invoice_details[:updated_at].to_s)
  end
  
  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end
end