class Transaction

  attr_reader :id,
              :invoice_id

  def initialize(transaction_data)
    @id = transaction_data[:id].to_i
    @invoice_id = transaction_data[:invoice_id].to_i
  end
end
