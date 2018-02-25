require 'csv'
require_relative 'transaction'

class TransactionRepository
  def initialize(filepath, parent)
    @transactions = []
    @parent = parent
    load_items(filepath)
  end

  def all
    @transactions
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == cc_number
    end
  end

  def find_all_by_result(res)
    @transactions.find_all do |transaction|
      transaction.result == res
    end
  end

  def invoice_repo_finds_merchant_via_engine(id)
    @parent.engine_finds_merchant_via_merchant_repo(id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
