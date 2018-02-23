# frozen_string_literal: true

require 'CSV'
require 'pry'
require_relative 'transaction'

# Merchant Repository gets data from CSV
class TransactionRepository
  attr_reader :sales_engine

  def initialize(filepath, sales_engine)
    @transactions = []
    @sales_engine = sales_engine
    load_transactions(filepath)
  end

  def all
    @transactions
  end

  def load_transactions(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @transactions << Transaction.new(data, self)
    end
  end
end
