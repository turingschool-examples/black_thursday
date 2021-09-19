# frozen_string_literal: true

# Transaction class, built for the Black Thursday project!

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction)
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id]
    @credit_card_number = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result]
    @created_at = transaction[:created_at]
    @updated_at = transaction[:updated_at]
  end

  def update(attributes)
    @last_updated = Time.now
    @credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    @result = attributes[:result] unless attributes[:result].nil?
    self
  end
end
