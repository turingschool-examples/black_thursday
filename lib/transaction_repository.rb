require_relative 'searching'
require_relative 'transaction'

# Creates and manages transaction repository
class TransactionRepository
  include Searching
  attr_reader :all

  def initialize(file_path, sales_engine)
    @all = from_csv(file_path)
    @sales_engine = sales_engine
  end

  def add_elements(data)
    data.map { |row| Transaction.new(row, self) }
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def invoice(invoice_id)
    @sales_engine.find_transaction_invoice(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@all.length} rows>"
  end
end
