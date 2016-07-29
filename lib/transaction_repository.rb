require_relative '../lib/transaction'

class TransactionRepository
  attr_reader :list_of_transactions

  extend Forwardable
  def_delegators :@parent_engine, :find_invoice

  def initialize(transactions_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_transactions = populate_transactions(transactions_data)
  end

  def populate_transactions(transactions_data)
    transactions_data.map do |datum|
      Transaction.new(datum, self)
    end
  end

  def all
    list_of_transactions
  end

  def find_by_id(id_to_find)
    @list_of_transactions.find do |transaction|
      transaction.id == id_to_find
    end
  end

  def find_all_by_invoice_id(invoice_id_to_find)
    @list_of_transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id_to_find
    end
  end

  def find_all_by_credit_card_number(credit_card_number_to_find)
    @list_of_transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number_to_find
    end
  end

  def find_all_by_result(result_to_find)
    @list_of_transactions.find_all do |transaction|
      transaction.result == result_to_find
    end
  end

  # just for the spec harness
  def inspect
  end

end
