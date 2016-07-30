class Invoice
  attr_reader :id

  def initialize(invoice, invoice_repository_parent = nil)
    # @invoice_repository_parent = invoice_repository_parent
    @id                        = invoice[:id].to_i

  end

  end




# id - returns the integer id
#
# customer_id - returns the customer id
#
# merchant_id - returns the merchant id
#
# status - returns the status
#
# created_at - returns a Time instance for the date the item was first created
#
# updated_at - returns a Time instance for the date the item was last modified
