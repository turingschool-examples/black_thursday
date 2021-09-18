require 'bigdecimal'
require 'time'

class Transaction
  attr_reader :id,
              :created_at,
              :updated_at,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result

  def initialize(info)
    @id                          = info[:id].to_i
    @created_at                  = Time.parse(info[:created_at])
    @updated_at                  = Time.parse(info[:updated_at])
    @invoice_id                  = info[:invoice_id].to_i
    @credit_card_number          = info[:credit_card_number]
    @credit_card_expiration_date = info[:credit_card_expiration_date]
    @result                      = info[:result]
  end
end 
