require 'csv'
# require_relative '../lib/transaction.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class TransactionRepository

  attr_reader :transactions
  include RepoMethodHelper

  def initialize(transaction_location)
    @transaction_location = transaction_location
    @transactions = []
  end
end
