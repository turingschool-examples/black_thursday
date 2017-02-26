class Transaction
  attr_reader :transaction_hash, :repository
  def initialize(hash, repository = '')
    @transaction_hash = hash
    @repository = repository
  end

  def id
    transaction_hash[:id]
  end

  def invoice_id
    transaction_hash[:invoice_id]
  end

  def credit_card_number
    transaction_hash[:credit_card_number]
  end

  def credit_card_expiration_date
    transaction_hash[:credit_card_expiration_date]
  end

  def result
    transaction_hash[:result]
  end

  def created_at
    transaction_hash[:created_at]
  end

  def updated_at
    transaction_hash[:updated_at]
  end

  def invoice
    repository.engine.invoices.find_by_id(invoice_id)
  end
end
