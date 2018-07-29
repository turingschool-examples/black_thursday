require 'time'
class Invoice
  attr_accessor :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :updated_at,
              :status

  def initialize(invoice_info)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @merchant_id = invoice_info[:merchant_id].to_i
    @status = invoice_info[:status].to_sym
    @created_at = Time.parse(invoice_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_info[:updated_at].to_s)
  end
end
