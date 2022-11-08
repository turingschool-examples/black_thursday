# frozen_string_literal: true

require 'timeable'

# This is the transaction class
class Transaction
  include Timeable
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_time,
              :updated_time

  def initialize(data, repo)
    @item_repo                   = repo
    @id                          = data[:id].to_i
    @invoice_id                  = data[:invoice_id].to_i
    @credit_card_number          = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @created_time                = data[:created_at]
    @updated_time                = data[:updated_at]
    @result                      = data[:result].to_sym
  end

  def update(attributes)
    @credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    @result = attributes[:result] unless attributes[:result].nil?
    @updated_time = Time.now
  end
end
