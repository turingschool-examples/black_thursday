require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result, :created_at,
              :updated_at, :transaction_repo

  def initialize(t_hash, transaction_repo)
    @id                          = t_hash[:id].to_i
    @invoice_id                  = t_hash[:invoice_id].to_i
    @credit_card_number          = t_hash[:credit_card_number].to_i
    @credit_card_expiration_date = t_hash[:credit_card_expiration_date]
    @result                      = t_hash[:result]
    @created_at                  = Time.parse(t_hash[:created_at])
    @updated_at                  = Time.parse(t_hash[:updated_at])
    @transaction_repo            = transaction_repo
  end

  def invoice
    @transaction_repo.find_invoices_by_transaction(invoice_id)

  end
end
