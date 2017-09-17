require_relative 'csv_parser'
require_relative 'transaction'

class TransactionRepository
  include CsvParser
  attr_accessor :transactions

  def initialize(file_name, sales_engine)
    @transactions = []
    item_contents = parse_data(file_name)
    item_contents.each {|row| @transactions << Transaction.new(row,self)}
    @sales_engine = sales_engine
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

  def find_all_invoices_by_invoice_id(invoice_id)
    @sales_engine.invoices.find_by_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
