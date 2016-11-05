require_relative 'transaction'
require 'csv'

class TransactionRepository
  attr_reader   :contents,
                :transactions,
                :parent

  def initialize(path, parent = nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @parent = parent
    @transactions = contents.map do |line|
      Transaction.new(line, self)
    end
  end

  def all
    transactions
  end

  def find_by_id(id_number)
    all.find do |transaction|
      transaction.id == id_number
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end