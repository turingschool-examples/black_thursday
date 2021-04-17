require 'bigdecimal'
require 'CSV'
require 'time'
require 'item'
require_relative './spec/transaction'

class TransactionRepo
  attr_reader :transactions
  def initialize(path, engine)
    @transactions = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |transaction_info|
      @transactions << Transaction.new(transaction_info, @engine)
    end
  end

  def all
    @transactions
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def find_by_id(id) #clarify passing in id
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_by_id_invoice_id(invoice_id)
    @transactions.find do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(number)
    @transactions.find_all do |transaction|
      transaction.number == number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    transaction = Transaction.new(attributes, @engine)
    max = @transactions.max_by do |transaction|
      transaction.id
    end
    transaction.id = max.id + 1
    add_transaction(transaction)
    return transaction
  end

end
