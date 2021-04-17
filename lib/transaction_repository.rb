# frozen_string_literal: true

require_relative './transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(filename)
    @transactions = create_transactions(filename)
  end

  def create_transactions(filename)
    FileIo.process_csv(filename, Transaction)
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end
end
