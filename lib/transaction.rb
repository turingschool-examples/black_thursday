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
    @id = transaction[:id]
    @invoice_id = transaction[:invoice_id]
    @credit_card_number = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result]
    @created_at = transaction[:created_at]
    @updated_at = transaction[:updated_at]
  end
end
