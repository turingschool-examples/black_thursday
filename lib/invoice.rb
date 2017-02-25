require 'time'

class Invoice
    attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row, parent=nil)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status]
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @parent = parent
  end
end

# id - returns the integer id
# customer_id - returns the customer id
# merchant_id - returns the merchant id
# status - returns the status
# created_at - returns a Time instance for the date the item was first created
# updated_at - returns a Time instance for the date the item was last modified

# id	customer_id	merchant_id	status	created_at	updated_at
