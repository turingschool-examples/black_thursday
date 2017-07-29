require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result, :created_at,
              :updated_at, :transaction_repo

  def initialize(transaction_hash, transaction_repo)
    @id                          = transaction_hash[:id].to_i
    @invoice_id                  = transaction_hash[:invoice_id]
    @credit_card_number          = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date]
    @result                      = transaction_hash[:result]
    @created_at                  = Time.parse(transaction_hash[:created_at])
    @updated_at                  = Time.parse(transaction_hash[:updated_at])
    @transaction_repo            = transaction_repo
  end

end
