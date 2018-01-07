require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repo

  def initialize(row, transaction_repo)
    @id                          = row[:id]
    @invoice_id                  = row[:invoice_id]
    @credit_card_number          = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result                      = row[:result]
    @created_at                  = Time.parse(row[:created_at])
    @updated_at                  = Time.parse(row[:updated_at])
    @trans_repo                  = transaction_repo
  end

end