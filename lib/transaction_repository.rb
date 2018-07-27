require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class TransactionRepository
  include Repository

  def initialize(transaction_items)
    @list = transaction_items
  end
  
end
