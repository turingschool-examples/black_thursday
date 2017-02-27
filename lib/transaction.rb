class Transaction
  attr_reader :transaction_info, :trans_inv_instance
  def initialize (transaction_info, trans_inv_instance)
    @transaction_info = transaction_info
    @trans_inv_instance = trans_inv_instance
  end

  def id
    transaction_info[:id]
  end

  def invoice_id
    transaction_info[:invoice_id]
  end

  def credit_card_number
    transaction_info[:credit_card_number]
  end

  def result
    transaction_info[:result]
  end

  def created_at
    transaction_info[:created_at]
  end

  def updated_at
    transaction_info[:updated_at]
  end
end
