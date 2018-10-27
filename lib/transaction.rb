class Transaction

  attr_reader :id

  def initialize(transaction_data)
    @id = transaction_data[:id].to_i
  end
end
