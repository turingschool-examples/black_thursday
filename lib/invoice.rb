require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(invoice_data)
    @id = invoice_data[:id].to_i
    @customer_id = invoice_data[:customer_id].to_i
    @merchant_id = invoice_data[:merchant_id].to_i
    @status = invoice_data[:status].to_sym
    @created_at = Time.parse(invoice_data[:created_at].to_s)
    @updated_at = Time.parse(invoice_data[:updated_at].to_s)
  end
end
