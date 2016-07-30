require 'bigdecimal'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent
  
  def initialize(transaction_details, repo = nil)
    @id                          = transacion_details[:id].to_i 
    @invoice_id                  = transacion_details[:invoice_id].to_i
    @credit_card_number          = transacion_details[:quantity].to_i
    @credit_card_expiration_date = transacion_details[:quantity].to_i
    @result                      = transacion_details[:result].to_s
    @created_at                  = format_time(transacion_details[:created_at].to_s)
    @updated_at                  = format_time(transacion_details[:updated_at].to_s)
    @parent                      = repo
  end
  
  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end
  
end

id - returns the integer id
invoice_id - returns the invoice id
credit_card_number - returns the credit card number
credit_card_expiration_date - returns the credit card expiration date
result - the transaction result
created_at - returns a Time instance for the date the transaction was first created
updated_at - returns a Time instance for the date the transaction was last modified