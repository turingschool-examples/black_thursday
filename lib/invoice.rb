
class Invoice
  def initialize(data)
    @id          = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status      = data[:status]
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:update_at])
  end
end
