require_relative '../lib/transaction'
require_relative '../lib/repository'

class TransactionRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_transactions(@parsed_csv_data)
  end

  def create_transactions(parsed_csv_data)
    parsed_csv_data.map do |transaction|
      Transaction.new(transaction)
    end
  end

end
