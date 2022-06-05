require 'helper'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at

  attr_accessor :updated_at

  def initialize(input)
    @id = input[:id].to_i
    @invoice_id = input[:invoice_id].to_i
    @credit_card_number = input[:credit_card_number]
    @credit_card_expiration_date = input[:credit_card_expiration_date]
    @result = input[:result]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def credit_card_expiration_date_to_dollars
    @credit_card_expiration_date.to_f
  end
end
