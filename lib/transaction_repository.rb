require_relative 'transaction'
require_relative 'csv_parser'

class TransactionRepository
include CsvParser

  def initialize
    @transactions = []
  end

  def from_csv(file_name)
    item_contents = parse_data(file_name)
    item_contents.each {|row| @transactions << Transaction.new(row,self)}
      #should live in it's own method. too much logic in the initialize
      #(some people will say that you should'nt have behavior in initialize, only state)
  end

  def all
    @transactions
  end

  def find_by_id(id)
      @transactions.find {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.select {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.select {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    @transactions.select {|transaction| transaction.result == result}
  end
end
