require 'time'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(invoice_info, invoice_repo)
    @id =             invoice_info[:name]
    @customer_id =    invoice_info[:customer_id]
    @merchant_id =    invoice_info[:merchant_id]
    @status =         invoice_info[:status]
    @created_at =     Time.parse(invoice_info[:created_at])
    @updated_at =     Time.parse(invoice_info[:updated_at])
  end

end
