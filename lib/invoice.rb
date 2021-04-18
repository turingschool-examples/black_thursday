class Invoice

  attr_accessor :id,
                :customer_id,
                :merchant_id,
                :status, 
                :created_at,
                :updated_at,
                :repo
  def initialize(invoice_info, repo)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id]
    @merchant_id = invoice_info[:merchant_id]
    @status = invoice_info[:status]
    @created_at = Time.parse(invoice_info[:created_at].to_s)
    @updated_at = Time.parse(invoice_info[:updated_at].to_s)
    @repo = repo
  end
end