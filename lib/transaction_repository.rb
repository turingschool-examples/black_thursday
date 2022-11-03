require_relative 'find'
require_relative 'modify'
require_relative 'transaction'

class TransactionRepository
  include Find
  include Modify

  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def add(transaction)
    @transactions << Transaction.new(transaction)
  end
end