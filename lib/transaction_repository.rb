# frozen_string_literal: true

require_relative './transaction'
require_relative './repository_helper'

# Transaction repository class
class TransactionRepository
  include RepositoryHelper

  def initialize
    @transactions = {}
  end

  def create(params)
    params[:id] = @transactions.max[0] + 1 if params[:id].nil?

    Transaction.new(params).tap do |transaction|
      @transactions[params[:id].to_i] = transaction
    end
  end

  def update(id, params)
    return nil unless @transactions.key?(id)
    trans = find_by_id(id)
    trans.credit_card_number = params[:credit_card_number] unless params[:credit_card_number].nil?
    trans.credit_card_expiration_date = params[:credit_card_expiration_date] unless params[:credit_card_expiration_date].nil?
    trans.result = params[:result] unless params[:result].nil?
    trans.updated_at = Time.now
  end

  def all
    transaction_pairs = @transactions.to_a.flatten
    remove_keys(transaction_pairs, Transaction)
  end

  def find_by_id(id)
    return nil unless @transactions.key?(id)
    @transactions.fetch(id)
  end

  def find_all_by_invoice_id(invoice_id)
    found_transactions = @transactions.find_all do |_, transaction|
      transaction.invoice_id == invoice_id
    end.flatten
    remove_keys(found_transactions, Transaction)
  end

  def find_all_by_credit_card_number(number)
    found_transactions = @transactions.find_all do |_, transaction|
      transaction.credit_card_number == number
    end.flatten
    remove_keys(found_transactions, Transaction)
  end

  def find_all_by_result(result)
    found_transactions = @transactions.find_all do |_, transaction|
      transaction.result == result
    end.flatten
    remove_keys(found_transactions, Transaction)
  end

  def delete(id)
    @transactions.delete(id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
