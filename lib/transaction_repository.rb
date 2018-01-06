require 'csv'
require_relative 'transaction'

class Transaction_Repository

  def initialize(path, sales_engine = "")
    @tranactions = {}
    @parent = sales_engine
    transaction_creator_and_storer(path)
  end

  def csv_opener(path = "./data/merchants.csv")
    argument_raiser(path)
    CSV.open path, headers: true, header_converters: :symbol
  end

  def transaction_creator_and_storer(path)
    argument_raiser(path)
    csv_opener(path).each do |merchant|
      new_transaction = Transaction.new(transaction, self)
      @transactions[transaction.id] = transaction
    end
  end
end
