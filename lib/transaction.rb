require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
  :credit_card_expiration_date, :result, :created_at, :updated_at,
  :transaction_repo

  def initialize(transactions, transaction_repo)
    @id = transactions[:id].to_i
    @invoice_id = transactions[:invoice_id].to_i
    @credit_card_number = transactions[:credit_card_number].to_i
    @credit_card_expiration_date = transactions[:credit_card_expiration_date]
    @result = transactions[:result]
    @created_at = Time.parse(transactions[:created_at])
    @updated_at =Time.parse(transactions[:updated_at])
    @transaction_repo = transaction_repo
  end

  def invoice
    transaction_repo.transaction_invoice(self.invoice_id)
  end

end
