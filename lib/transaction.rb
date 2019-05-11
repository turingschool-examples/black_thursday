# frozen_string_literal: true

require 'time'
require 'bigdecimal'

# transaction
class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repository

  def initialize(data, parent)
    @id                          = data[:id].to_i
    @invoice_id                  = data[:invoice_id].to_i
    @credit_card_number          = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result                      = data[:result].to_sym
    @created_at                  = Time.parse(data[:created_at])
    @updated_at                  = Time.parse(data[:updated_at])
    @transaction_repository      = parent
  end

  def change_updated_at
    @updated_at = Time.now
  end

  def change_credit_card_number(number)
    @credit_card_number = number
  end

  def change_expiration_date(date)
    @credit_card_expiration_date = date.to_s
  end

  def change_result(result)
    @result = result.to_sym
  end
end
