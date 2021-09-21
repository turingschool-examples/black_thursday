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

  def find_by_id(id)
    if (@all.any? do |transaction|
      transaction.id == id
    end) == true
      @all.find do |transaction|
        transaction.id == id
      end
    else
      nil
    end
  end
end
