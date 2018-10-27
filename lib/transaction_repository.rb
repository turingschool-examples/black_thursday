require 'pry'
require 'CSV'
require_relative './repository'

class TransactionRepository < Repository

  def new_record(row)
    Transaction.new(row)
  end

end
