class Invoice

  def initialize(invoice_hash)
    @id = invoice_hash[:id]
    @customer_id = invoice_hash[:customer_id]
    @merchant_id = invoice_hash[:merchant_id]
    @status = invoice_hash[:status]
    @created_at = Time.parse(invoice_hash[:created_at])
    @updated_at = Time.parse(invoice_hash[:updated_at])
  end


end

# The invoice has the following data accessible:
#
# id - returns the integer id
# customer_id - returns the customer id
# merchant_id - returns the merchant id
# status - returns the status
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified
