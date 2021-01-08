class Invoice
  def initialize(data, repo)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

end
