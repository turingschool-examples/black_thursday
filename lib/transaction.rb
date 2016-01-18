require 'pry'
require 'time'
require 'bigdecimal'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(trans_info)
    @id                          = trans_info[:id].to_i
    @invoice_id                  = trans_info[:invoice_id].to_i
    @credit_card_number          = BigDecimal.new(trans_info[:credit_card_number]).to_i
    @credit_card_expiration_date = trans_info[:credit_card_expiration_date].to_i
    @result                      = trans_info[:result]
    @created_at                  = Time.parse(trans_info[:created_at])
    @updated_at                  = Time.parse(trans_info[:updated_at])
  end

end
