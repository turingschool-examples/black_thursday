class TransactionRepository
  attr_reader :transactions
  
  def initialize
    @transactions = []
  end
end