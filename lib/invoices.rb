require 'pry'

class Invoices

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice_hash)
    @id           = invoice_hash[:id].to_i
    @customer_id  = invoice_hash[:customer_id].to_i
    @merchant_id  = invoice_hash[:merchant_id].to_i
    @status       = invoice_hash[:status]
    @created_at   = determine_the_time(invoice_hash[:created_at])
    @updated_at   = determine_the_time(invoice_hash[:updated_at])
  end

  def determine_the_time(time)
    time = Time.parse(time)
  end

end
