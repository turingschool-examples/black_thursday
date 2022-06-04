class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date

  def initialize(info)
    @id = info[:id]
    @invoice_id = info[:invoice_id]
    @credit_card_number = info[:credit_card_number].to_i
    @credit_card_expiration_date = info[:credit_card_expiration_date]
  end
end
