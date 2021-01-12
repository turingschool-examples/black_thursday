class Transaction
  attr_reader:id,
             :invoice_id,
             :created_at,
             :transaction_repo

  attr_accessor:credit_card_number,
               :credit_card_expiration_date,
               :result,
               :updated_at

  def initialize(data, transaction_repo)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @transaction_repo = transaction_repo
  end
end
