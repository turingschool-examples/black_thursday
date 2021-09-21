class TransactionRepository
  attr_reader :all

  def initialize(transaction_path)
    @all = (
      transaction_objects = []
      CSV.foreach(transaction_path, headers: true, header_converters: :symbol) do |row|
        transaction_objects << Transaction.new(row)
      end
      transaction_objects)
  end
end
