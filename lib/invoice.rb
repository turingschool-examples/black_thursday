class Invoice
  attr_reader :id,
              :customer_id

  def initialize(transaction_details)
    @id = transaction_details[:id]
    @customer_id = transaction_details[:customer_id]
  end
end
