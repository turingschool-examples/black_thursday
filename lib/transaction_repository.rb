require_relative 'find'

class TransactionRepository
  include Find

  attr_reader :transactions

  def initialize
    @transactions = []
  end
end