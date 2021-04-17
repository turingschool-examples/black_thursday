class Transaction
  attr_reader :id,
              :invoice_id,
              :created_at,
              :repository
  attr_accessor :updated_at,
                :credit_card_number,
                :credit_card_expiration_date,
                :result

  def initialize(transaction_info)
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id].to_i
    @credit_card_number = transaction_info[:credit_card_number].to_i
    @credit_card_expiration_date = transaction_info[:credit_card_expiration_date].to_i
    @result = transaction_info[:result].to_sym
    @created_at = transaction_info[:created_at]
    @updated_at = transaction_info[:updated_at]
    @repository = repository
  end
end
