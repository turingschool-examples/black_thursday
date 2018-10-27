require 'time'
class Invoice
  attr_reader :id, :customer_id
  def initialize(invoice_info)
    @id          = invoice_info[:id]
    @customer_id = invoice_info[:customer_id]
    # @merchant_id = merchant_id
    # @status      = status
    # @created_at  = created_at
    # @updated_at  = updated_at
  end
end
