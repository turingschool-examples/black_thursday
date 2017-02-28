class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction, parent)
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id]
    @credit_card_number = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result].to_sym
    @created_at = transaction[:created_at]
    @updated_at = transaction[:updated_at]
    # @created_at = Time.parse(transaction[:created_at])
    # @updated_at = Time.parse(transaction[:updated_at])
    @parent = parent
  end

end
