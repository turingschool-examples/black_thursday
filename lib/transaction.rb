class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
              
  def initialize(records, repo)
    @id         = records[:id]
    @invoice_id = records[:invoice_id]
    @credit_card_number = records[:credit_card_number]
    @credit_card_expiration_date = records[:credit_card_expiration_date]
    @result     = records[:result]
    @created_at = records[:created_at]
    @updated_at = records[:updated_at]
    @repo       = repo
  end
end