# frozen_string_literal: true
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
    @result                      = info[:result].to_sym
  end

  def change_credit_card_number(credit_card_number)
    @credit_card_number = credit_card_number
    @updated_at = Time.now.utc
  end

  def change_credit_card_expiration_date(credit_card_expiration_date)
    @credit_card_expiration_date = credit_card_expiration_date
    @updated_at = Time.now.utc
  end

  def change_result(result)
    @result = result
    @updated_at = Time.now.utc
  end
end
