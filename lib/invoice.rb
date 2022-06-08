require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  attr_writer :status,
              :updated_at

  def initialize(invoice)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].to_sym
    @created_at = Time.parse(invoice[:created_at].to_s)
    @updated_at = Time.parse(invoice[:updated_at].to_s)
  end

end
