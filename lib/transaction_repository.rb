require 'csv'
require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository

  attr_reader :klass, :data, :transactions

  def initialize(sales_engine, path)
    super(sales_engine, path, Transaction)
    @transactions = transactions
  end

  def all
    data
  end

  def find_by_id(id)
    data.select { |transaction| transaction.id == id }.first
  end

  def find_all_by_invoice_id(invoice_id)
    data.select { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(cc_number)
    data.select { |transaction| transaction.credit_card_number == cc_number }
  end

  def find_all_by_result(result)
    data.select { |transaction| transaction.result == result }
  end

end
