class Transaction

  attr_reader :id, :invoice_id, :created_at

  attr_accessor :credit_card_number, :credit_card_expiration_date,
                :result, :updated_at

  def initialize(transaction_data)
    @id                          = transaction_data[:id]
    @invoice_id                  = transaction_data[:invoice_id]
    @credit_card_number          = transaction_data[:credit_card_number]
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
    @result                      = transaction_data[:result]
    @created_at                  = transaction_data[:created_at]
    @updated_at                  = transaction_data[:updated_at]
  end

end
