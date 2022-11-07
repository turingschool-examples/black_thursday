require_relative 'sanitize'
require 'time'

class Transaction
include Sanitize
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @invoice_id = info[:invoice_id].to_i
    @credit_card_number = info[:credit_card_number]
    @credit_card_expiration_date = info[:credit_card_expiration_date]
    @result = info[:result].to_sym
    @created_at = to_time(info[:created_at])
    @updated_at = to_time(info[:updated_at])
  end

  def update(attributes)
    @credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    @result = attributes[:result] if attributes[:result]
    @updated_at = Time.now
    self
  end
end