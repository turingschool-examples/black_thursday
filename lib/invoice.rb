class Invoice
  attr_reader :id, :customer_id, :merchant_id

  def initialize(invoice)
    @id = invoice[:id]
    @customer_id = invoice[:customer_id]
    @merchant_id = invoice[:merchant_id]
  end
end
