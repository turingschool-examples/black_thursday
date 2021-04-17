class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status, 
              :created_at,
              :updated_at
  def initialize(invoice_info)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id]
    @merchant_id = invoice_info[:merchant_id]
    @status = invoice_info[:status]
    @created_at = Time.now
    @updated_at = Time.now
    # @repo = repo
  end
end