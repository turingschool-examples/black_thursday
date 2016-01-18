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

  def find_by_id(trans_id)
    transactions.find { |trans| trans.id == trans_id.to_i}
  end

  def find_all_by_invoice_id(trans_id)
    transactions.find_all {|trans| trans.invoice_id == trans_id.to_i}
  end

  def find_all_by_credit_card_number(trans_id)
    transactions.find_all { |trans| trans.credit_card_number == trans_id.to_i}
  end

  def find_all_by_result(trans_id)
    transactions.find_all {|trans| trans.result == trans_id.downcase}
  end

end
