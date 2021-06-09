class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :repo

  def initialize(transaction_data, repo)
    @id = transaction_data[:id]
    @invoice_id = transaction_data[:invoice_id]
    @credit_card_number = transaction_data[:credit_card_number]
    @credit_card_expiration_date = transaction_data[:credit_card_expiration_date]
    @result = transaction_data[:result]
    @created_at = transaction_data[:created_at]
    @updated_at = transaction_data[:updated_at]
    @repo = repo
  end

  def new_id(id_number)
    @id = id_number
  end
end
