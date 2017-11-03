
class Invoice
  attr_reader :invoice, :id, :customer_id, :merchant_id, :status, :created_at,    :updated_at

  def initialize(invoice)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status]
    @created_at = Time.parse(invoice[:created_at])
    @updated_at = Time.parse(invoice[:updated_at])
  end
end
