# frozen_string_literal: true

require_relative './transaction'

# Transaction repository class
class TransactionRepository
  def initialize
    @transactions = {}
  end

  def create(params)
    params[:id] = @transactions.max[0] + 1 if params[:id].nil?

    Transaction.new(params).tap do |transaction|
      @transactions[params[:id].to_i] = transaction
    end
  end

  def all
    transaction_pairs = @transactions.to_a.flatten
    transaction_pairs.keep_if do |element|
      element.is_a?(Transaction)
    end
  end
end
