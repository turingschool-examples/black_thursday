# Transaction Repo
require 'pry'
class TransactionRepository
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def all
    @transactions
  end
end
