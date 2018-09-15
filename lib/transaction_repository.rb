require 'pry'

require_relative 'csv_parse'
require_relative 'transaction'


class TransactionRepository

  attr_reader :all,
              :transactions

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @transactions = []
    make_transactions
    @all = transactions
  end

  def make_transactions
    @csv.each { |key, value|
      hash = make_hash(key, value)
      transaction = Transaction.new(hash)
      @transactions << transaction
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end

end
