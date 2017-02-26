require 'csv'
require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, Transaction)
  end

  def all
    data
  end

end
