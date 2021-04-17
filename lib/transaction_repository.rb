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
end
