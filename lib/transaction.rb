class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result = attributes[:result].to_sym
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def update(attributes)
    @credit_card_number = attributes[:credit_card_number] || @credit_card_number
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] || @credit_card_expiration_date
    @result = attributes[:result] || @result
    @updated_at = Time.new
  end
end
