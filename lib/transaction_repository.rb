require 'csv'

class TransactionRepository
  def initialize(file_path)
    @transactions = []
    transaction_data = CSV.open, headers: true, header_converters: :symbol, converters: :numeric
    parse(transaction_data)
  end

  def from_csv(file_path)
    new(file_path)
  end

  def all
    return @transactions
  end
end
