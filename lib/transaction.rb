class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(t_data)
    @id = t_data[:id]
    @invoice_id = t_data[:invoice_id]
    @credit_card_number = t_data[:credit_card_number]
    @credit_card_expiration_date = t_data[:credit_card_expiration_date]
    @result = t_data[:result]
    @created_at = t_data[:created_at]
    @updated_at = t_data[:updated_at]
  end
end
