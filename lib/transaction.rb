class Transaction
  attr_accessor :id,
                :invoice_id,
                :credit_card_number

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
  end
end