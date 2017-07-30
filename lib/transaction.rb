class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number

  def initialize(transaction_info, transaction_repo)
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id].to_i
    @credit_card_number = transaction_info[:credit_card_number].to_i
  end

end
