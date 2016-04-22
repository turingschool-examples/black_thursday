class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(transaction_data)
    @id = transaction_data[:id].to_i
    @invoice_id = transaction_data[:transaction_data].to_i
    @credit_card_number = transaction_data[:credit_card_number]
      # spec shows cc# as string
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
      #spec shows 4 digit string
    @result = transaction_data[:success]
    @created_at = transaction_data[:created_at]
    @updated_at = transaction_data[:updated_at]
  end

end
