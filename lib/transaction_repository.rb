require_relative 'transaction'
require          'csv'
require          'pry'

class TransactionRepository
  attr_reader :transactions

  def initialize(csv_hash)
    @transactions = csv_hash.map {|csv_hash| Transaction.new(csv_hash) }
  end

  def all
    transactions
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

#   all - returns an array of all known Transaction instances
# find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
# find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
# find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
# find_all_by_result - returns either [] or one or more matches which have a matching status

end
