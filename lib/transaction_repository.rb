require 'csv'
require_relative "transaction"

class TransactionRepository

  attr_reader     :all,
                  :sales_engine

  def initialize(parent = nil)
    @all = []
    @sales_engine = parent
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end

  


end
