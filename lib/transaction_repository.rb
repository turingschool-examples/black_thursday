require 'csv'
require_relative '../lib/transaction'
require_relative '../lib/create_elements'


class TransactionRepository

  include CreateElements

  attr_reader :transactions, :engine

  def initialize(transactions_file, engine)
    @transactions = create_elements(transactions_file).map {|transaction| Transaction.new(transaction, self)}
    @engine = engine
  end

  def all
    return transactions
  end

end



=begin

all - returns an array of all known Transaction instances
find_by_id - returns either nil or an instance of Transaction with a matching ID
find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
find_all_by_result - returns either [] or one or more matches which have a matching status

=end
