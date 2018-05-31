require_relative 'repository'
require_relative 'transaction'

class TransactionRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |transaction| Transaction.new(transaction)}
  end

  def all
    @repository
  end

  def inspect
   "#{self.class} #{@repository.size} rows"
  end
end
