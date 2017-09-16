require 'csv'
require_relative 'transaction'

class TransactionRepo
  attr_reader :transactions, :parent

  def initialize(file, se=nil)
    open_file(file)
    @parent = se
  end

  def open_file(file)
    csv = CSV.foreach file,
    headers: true, header_converters: :symbol
    @transactions = csv.map do |row|
      Transaction.new(row, self)
    end
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find { |t| t.id == id }
  end

  def find_all_by_invoice_id(id)
    transactions.find_all { |t| t.invoice_id == id }
  end

  def find_all_by_credit_card_number(cc_num)
    transactions.find_all { |t| t.credit_card_number == cc_num }
  end

  def find_all_by_result(result)
    transactions.find_all { |t| t.result == result}
  end

end
