require_relative 'transaction'
require          'csv'
require          'pry'

class TransactionRepository
  attr_reader :transactions

  def initialize(csv_hash)
    @transactions = csv_hash.map {|csv_hash| Transaction.new(csv_hash) }
  end

  def all
    transactions
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
end




end
