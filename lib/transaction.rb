class Transaction
  attr_reader :id, :invoice_id, :credit_card_number

  def initialize(info)
    @id = info[:id]
    @invoice_id = info[:invoice_id]
    @credit_card_number = info[:credit_card_number].to_i
  end
end
