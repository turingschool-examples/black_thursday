class Invoice

attr_reader :id,
            :customer_id,
            :merchant_id,
            :status,
            :invoice_created_at,
            :invoice_updated_at

  def initialize(invoice, invoice_repo_parent = nil)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status]
    @invoice_created_at = invoice[:created_at]
    @invoice_updated_at = invoice[:updated_at]
    @parent = invoice_repo_parent
  end

end
