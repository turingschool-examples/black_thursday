class Transaction
  attr_reader :transaction, :transaction_repo

  def initialize(transaction, transaction_repo)
    @transaction = transaction
    @transaction_repo = transaction_repo
  end

  def id
    transaction.fetch(:id).to_i
  end

  def invoice_id
    transaction.fetch(:invoice_id).to_i
  end

  def credit_card_number
    transaction.fetch(:credit_card_number).to_i
  end

  def credit_card_expiration_date
    transaction.fetch(:credit_card_expiration_date)
  end

  def result
    transaction.fetch(:result)
  end

  def created_at
    Time.parse(transaction.fetch(:created_at))
  end

  def updated_at
    Time.parse(transaction.fetch(:updated_at))
  end

  def invoice
    transaction_repo.transaction_invoice(self.invoice_id)
  end
end
