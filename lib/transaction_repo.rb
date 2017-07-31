require 'csv'
require_relative 'transaction'

class TransactionRepo
  attr_reader :transactions, :parent

  def initialize(filename, se=nil)
    @transactions = {}
    open_file(filename)
    @parent       = se
  end

  def open_file(filename)
    CSV.foreach filename, headers: true, header_converters: :symbol do |row|
      transactions[row[:id].to_i] = Transaction.new(row, self)
    end
  end

  def all
    transactions.values
  end

  def find_by_id(id)
    transactions[id]
  end

  def find_all_by_invoice_id(inv_id)
    all.find_all {|transaction| transaction.invoice_id == inv_id}
  end

  def find_all_by_credit_card_number(cc_num)
    all.find_all {|transaction| transaction.credit_card_number == cc_num.to_i}
  end

  def find_all_by_result(status)
    all.find_all{|transaction| transaction.result == status}
  end

  def transaction_invoice(id)
    parent.transaction_invoice(id)
  end
end
