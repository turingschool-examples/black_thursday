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

  def all
    @transactions
  end

  def add(transaction)
    @transactions << Transaction.new(transaction)
  end

  def find_by_id(id)
    find_by_id_overall(@transactions, id)
  end
end