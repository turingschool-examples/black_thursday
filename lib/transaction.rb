# frozen_string_literal: true

# This is the transaction class
class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :created_at,
              :updated_at,
              :result

  def initialize(data, repo)
    @item_repo                   = repo
    @id                          = data[:id]
    @invoice_id                  = data[:invoice_id]
    @credit_card_number          = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @created_at                  = data[:created_at]
    @updated_at                  = data[:updated_at]
    @result                      = data[:result]
  end

  def update(attributes)
    @credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    @result = attributes[:result] unless attributes[:result].nil?
    @updated_at = Time.now
  end
end
