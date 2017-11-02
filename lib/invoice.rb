
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :create_at,    :updated_at

  def initialize(invoice)
    @id = invoice[:id]
    @customer_id = invoice[:customer_id]
    @merchant_id = invoice[:merchant_id]
    @status = invoice[:status]
    @created_at = Time.parse(invoice[:create_at])
    @updated_at = Time.parse(invoice[:updated_at])
  end
end
