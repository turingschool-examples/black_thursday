require 'time'

class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :result,
              :created_at,
              :updated_at,
              :transaction_repo,
              :credit_card_expiration_date

  def initialize(row, parent)
    @id                          = row[:id].to_i
    @invoice_id                  = row[:invoice_id].to_i
    @credit_card_number          = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result                      = row[:result]
    @created_at                  = Time.parse(row[:created_at])
    @updated_at                  = Time.parse(row[:updated_at])
    @transaction_repo            = parent
  end

  def invoice
    transaction_repo.find_invoice_by_id(invoice_id)
  end

end
