class TransactionRepository

  attr_reader :transactions, :parent

  def initialize(tran, parent)
    @transactions = load_csv(tran).map {|row| Transaction.new(row, self)}
    @parent = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @transactions
  end

  def find_by_id(id)
    transactions.find {|transaction| transaction.id}
  end

end
