class Invoice
  attr_reader :id, :customer_id

  def initialize(invoice)
    @id = invoice[:id]
    @customer_id = invoice[:customer_id]
  end

end
