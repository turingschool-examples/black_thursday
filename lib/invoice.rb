class Invoice
  def initialize(data)
    @id - returns the integer id
    @customer_id - returns the customer id
    @merchant_id - returns the merchant id
    @status - returns the status
    @created_at Time.parse(data)
    @updated_at - returns a Time instance for the date the item was last modified
  end
end
