# frozen_string_literal: true

require_relative './transaction'
require_relative './repository_helper'

# Transaction repository class
class TransactionRepository
  include RepositoryHelper

  def initialize
    @repository = {}
  end

  def create(params)
    params[:id] = @repository.max[0] + 1 if params[:id].nil?

    Transaction.new(params).tap do |transaction|
      @repository[params[:id].to_i] = transaction
    end
  end

  def update(id, params)
    return nil unless @repository.key?(id)
    trans = find_by_id(id)
    trans.credit_card_number = params[:credit_card_number] unless params[:credit_card_number].nil?
    trans.credit_card_expiration_date = params[:credit_card_expiration_date] unless params[:credit_card_expiration_date].nil?
    trans.result = params[:result] unless params[:result].nil?
    trans.updated_at = Time.now
  end

  def all
    transaction_pairs = @repository.to_a.flatten
    remove_keys(transaction_pairs, Transaction)
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(number)
    all.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end
end
