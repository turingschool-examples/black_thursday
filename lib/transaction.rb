require 'pry'
require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at

  def initialize(trans_info)
    @id                          = trans_info[:id]
    @invoice_id                  = trans_info[:invoice_id]
    @credit_card_number          = trans_info[:credit_card_number]
    @credit_card_expiration_date = trans_info[:credit_card_expiration_date]
    @result                      = trans_info[:result]
    @created_at                  = trans_info[:created_at]
    @updated_at                  = trans_info[:updated_at]
  end

end

# id - returns the integer id
# invoice_id - returns the invoice id
# credit_card_number - returns the credit card number
# credit_card_expiration_date - returns the credit card expiration date
# result - the transaction result
# created_at - returns a Time instance for the date the transaction was first created
# updated_at - returns a Time instance for the date the transaction was last modified
# We create an instance like this:
#
