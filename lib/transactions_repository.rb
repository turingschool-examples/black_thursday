# Transaction Repo
require 'pry'
class TransactionsRepository
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
  end

  def all
    @transactions
  end
end
