require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'repository'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number

  def initialize(information)
    @id                          = information[:id].to_i
    @invoice_id                  = information[:invoice_id].to_i
    @credit_card_number          = information[:credit_card_number].to_s
    @credit_card_expiration_date = information[:credit_card_expiration_date].to_s
    @result                      = information[:result].to_s
    @created_at                  = Time.parse(information[:created_at].to_s)
    @updated_at                  = Time.parse(information[:updated_at].to_s)
  end

end
