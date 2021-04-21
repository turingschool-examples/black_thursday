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
    transaction.id = max.id + 1
    add_transaction(transaction)
    return transaction
  end

  def update(id, attributes)
    new_transaction = find_by_id(id)
    return if !new_transaction
    new_transaction.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
    new_transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    new_transaction.result = attributes[:result] if attributes[:result]
    new_transaction.updated_at = Time.now
    return new_transaction
  end

  def delete(id)
    @transactions.delete(find_by_id(id))
  end
end
