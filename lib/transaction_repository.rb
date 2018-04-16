require_relative './repository'
require_relative './transaction'

class TransactionRepository
  include Repository

  attr_reader :repository

  def initialize(transactions)
    transaction_array = []
    @repository = {}
    transactions.each { |transaction| transaction_array << Transaction.new(to_transaction(transaction))}
    transaction_array.each do |transaction|
      if transaction.nil?
      else
        @repository[transaction.id] = transaction
      end
    end
  end

  def to_transaction(transaction)
    transaction_hash = {}
    transaction.each do |line|
      transaction_hash[line[0]] = line[1]
    end
    transaction_hash
  end

  def find_all_by_invoice_id(tr)
    @repository.values.find_all do |transaction|
      transaction.invoice_id == tr
    end
  end

end
