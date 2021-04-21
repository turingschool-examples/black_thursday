require 'CSV'
require 'time'
require_relative 'transaction' #is this necessary
require_relative 'findable'
include Findable

class TransactionRepo
  attr_reader :transactions,
              :engine

  def initialize(path, engine)
    @transactions = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def create(attributes)
    transaction = Transaction.new(attributes, self)
    max = @transactions.max_by do |transaction|
      transaction.id
    end
    transaction.update_id(max.id)
    add_transaction(transaction)
    return transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id, @transactions)
    return if !transaction
    transaction.update_all(attributes)
  end

  def delete(id)
    @transactions.delete(find_by_id(id))
  end
end
