require_relative './repository'
require_relative './transaction'
require 'time'

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

  def find_all_by_credit_card_number(tr)
    @repository.values.find_all do |transaction|
      transaction.credit_card_number == tr
    end
  end

  def find_all_by_result(tr)
    @repository.values.find_all do |transaction|
      transaction.result == tr
    end
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if attributes[:created_at].nil?
      attributes[:created_at] = Time.now.to_s
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    attributes[:updated_at] = attributes[:updated_at].to_s
    transaction = Transaction.new(attributes)
    @repository[transaction.id] = transaction
  end

end
