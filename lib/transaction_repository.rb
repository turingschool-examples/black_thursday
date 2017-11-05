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

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result.downcase == result.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end


end



=begin

all - returns an array of all known Transaction instances
find_by_id - returns either nil or an instance of Transaction with a matching ID
find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
find_all_by_result - returns either [] or one or more matches which have a matching status

=end
