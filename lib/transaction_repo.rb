require_relative 'transaction'
require_relative 'module'

class TransactionRepository
  include IDManager

  attr_reader :all
  def initialize(transactions)
    @all = transactions
  end
end
