class Transaction

  attr_reader :id,
              :invoice_id

  def initialize(transaction_info, transaction_repo)
    @id = transaction_info[:id].to_i
    @invoice_id = transaction_info[:invoice_id].to_i
  end

end
