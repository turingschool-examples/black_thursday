class TransactionRepo
  attr_reader :transactions

  def initialize(filename, se=nil)
    @transactions = {}
    open_file(filename)
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      transactions[row[:id].to_i] = Transaction.new(row, self)
    end
  end

  def all
    transactions.values
  end
end
