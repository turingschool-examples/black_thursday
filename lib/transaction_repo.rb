require_relative './transaction'
require 'time'
require 'csv'
require 'bigdecimal'

class TransactionRepo
  attr_reader :transaction_list

  def initialize(csv_files, engine)
    @transaction_list = transaction_instances(csv_files)
    @engine = engine
  end

  def transaction_instances(csv_files)
    transactions = CSV.open(csv_files, headers: true, header_converters: :symbol)

    @transaction_list = transactions.map do |transaction|
      Transaction.new(transaction, self)
    end
  end

  def all
    @transaction_list
  end
end
