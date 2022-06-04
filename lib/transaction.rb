class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at

  def initialize(info)
    @id = info[:id]
    @invoice_id = info[:invoice_id]
    @credit_card_number = info[:credit_card_number].to_i
    @credit_card_expiration_date = info[:credit_card_expiration_date]
    @result = info[:result].downcase
    @created_at = info[:created_at]
  end
end
