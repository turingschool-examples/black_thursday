require 'csv'
require_relative 'transaction'
require_relative 'repository'

# Transation Repo
class TransactionRepository
  include Repository
  attr_reader :engine

  def initialize(filepath, parent = nil)
    @csv_items = []
    @engine   = parent
    load_children(filepath)
  end

  def transactions
    @csv_items
  end

  def child
    Transaction
  end

  def find_all_by_invoice_id(id)
    transactions.find_all { |transaction| transaction.invoice_id == id }
  end

  def find_all_by_credit_card_number(number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result == result.to_s }
  end

  def find_invoice_by_invoice_id(invoice_id)
    engine.find_invoice_by_invoice_id(invoice_id)
  end
end
