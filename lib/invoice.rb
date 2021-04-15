class Invoice
  attr_reader :id

  def initialize(transaction_details)
    @id = transaction_details[:id]
  end
end
