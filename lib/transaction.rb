class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(attributes, repository)
    @repository = repository
    @id = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number].to_i
    @credit_card_expiration_date = attributes[:credit_card_expiration_date].to_i
    @result = attributes[:result].to_sym
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def change_result(change)
    @result = change
  end

  def update_time(time)
    @updated_at = time
  end
end
