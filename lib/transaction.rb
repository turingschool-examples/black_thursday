class Transaction
  attr_reader :transaction_attributes

  def initialize(attributes)
    @transaction_attributes = attributes
    @transaction_attributes[:id] = transaction_attributes[:id].to_i
    @transaction_attributes[:invoice_id] = transaction_attributes[:invoice_id].to_i
    @transaction_attributes[:credit_card_number] = transaction_attributes[:credit_card_number].to_i
    @transaction_attributes[:credit_card_expiration_date] = transaction_attributes[:credit_card_expiration_date].to_i
    @transaction_attributes[:result] = transaction_attributes[:result]
    @transaction_attributes[:created_at] = transaction_attributes[:created_at]
    @transaction_attributes[:updated_at] = transaction_attributes[:updated_at]
  end
end
