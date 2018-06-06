# frozen_string_literal: false

require_relative 'transaction'
require_relative 'repository'
# Responsible for holding and searching Transaction instances
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
    attributes[:id] = find_highest_id.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    @repository << Transaction.new(attributes)
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    unless transaction.nil?
      transaction.result = attributes[:result] if attributes[:result]
      exp_date = attributes[:credit_card_expiration_date]
      transaction.credit_card_expiration_date = exp_date if exp_date
      cc_number = attributes[:credit_card_number]
      transaction.credit_card_number = cc_number if cc_number
      transaction.updated_at = Time.now
    end
    return nil
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
