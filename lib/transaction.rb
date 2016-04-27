class Transaction
  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at
  attr_accessor :invoice

  def initialize(transaction_data)
    @id = transaction_data[:id].to_i
    @invoice_id = transaction_data[:invoice_id].to_i
    @credit_card_number = transaction_data[:credit_card_number].to_i
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
    @result = transaction_data[:result]
    @created_at = Time.parse(transaction_data[:created_at])
    @updated_at = Time.parse(transaction_data[:updated_at])
  end

  def inspect
    "#<#{self.class}"
  end

end
