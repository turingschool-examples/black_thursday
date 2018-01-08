require 'time'
require "bigdecimal"

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
    @id                          = row[:id].to_i
    @invoice_id                  = row[:invoice_id].to_i
    @credit_card_number          = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date].to_s
    @result                      = row[:result]
    @created_at                  = Time.parse(row[:created_at])
    @updated_at                  = Time.parse(row[:updated_at])
    @transaction_repo            = transaction_repo
  end

  def invoice
    transaction_repo.find_by_invoice_id(self.invoice_id)
  end
end
