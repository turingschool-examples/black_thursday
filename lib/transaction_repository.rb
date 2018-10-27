class TransactionRepository

  def initialize
    @collection = {}
  end

  def add_transaction(transaction)
    @collection[transaction.id] = transaction
  end

end
