require 'csv'
require_relative './sales_engine'
require_relative './transaction'

class TransactionRepository
  def initialize(data)
     @transactions = data
  end

  def all
    @transactions
  end
  
end
