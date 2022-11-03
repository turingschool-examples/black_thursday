require_relative 'find'
require_relative 'modify'
require_relative 'transaction'
require 'pry'

class TransactionRepository
  include Find
  include Modify

  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def all
    @transactions
  end

  def add(transaction)
    @transactions << Transaction.new(transaction)
  end

  def find_by_id(id)
    find_by_id_overall(@transactions, id)
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    create_overall(@transactions, attributes)
  end
end