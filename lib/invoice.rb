class Invoice
  def initialize(data)
    @id=
    @customer_id - returns the customer id
    @merchant_id - returns the merchant id
    @status - returns the status
    @created_at Time.parse(data[:created_at])
    @updated_at - returns a Time instance for the date the item was last modified
  end
end
