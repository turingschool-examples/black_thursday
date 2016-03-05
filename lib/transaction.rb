class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date, :result,
              :created_at, :updated_at, :repository

  def initialize(transaction_hash, repository)
    @repository = repository
    @id = transaction_hash[:id].to_i
    @invoice_id = transaction_hash[:invoice_id].to_i
    @credit_card_number = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date]
    @result = transaction_hash[:result]
    @created_at = Time.parse(transaction_hash[:created_at])
    @updated_at = Time.parse(transaction_hash[:updated_at])
  end

  # def items
  #   @repository.find_items(@id)
  # end
end
