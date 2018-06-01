# frozen_string_literal: false

require_relative 'transaction'
require_relative 'repository'
# Responsible for holding and searching Transaction instances.
class TransactionRepository
  include Repository
  attr_reader :transactions

  def initialize(transactions)
    @transactions = transactions
    @repository = []
    create_all_transactions
  end

  def create_all_transactions
    @transactions.each do |transaction|
      @repository << Transaction.new(transaction)
    end
  end

  def create(attributes)
    highest_id = @repository.max_by(&:id)
    attributes[:id] = highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << Transaction.new(attributes)
  end

  def find_all_by_credit_card_number(cc_number)
    @repository.find_all do |transaction|
      cc_number == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    @repository.find_all do |transaction|
      result == transaction.result
    end
  end
end
