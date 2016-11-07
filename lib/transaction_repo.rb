require_relative './transaction'
require_relative './data_parser'

class TransactionRepo
  include DataParser
  attr_reader :all

  def initialize(file, parent = nil)
    @all    = parse_data(file).map { |row| Transaction.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    @all.find { |transaction| transaction.id.eql?(id) }
  end

  def find_all_by_invoice_id(id)
    @all.find_all { |transaction| transaction.invoice_id.eql?(id) }
  end

  def find_all_by_credit_card_number(card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number.eql?(card_number)
    end
  end

  def find_all_by_result(result)
    @all.find_all { |transaction| transaction.result.eql?(result) }
  end

  def find_invoice_by_invoice_id(id)
    @parent.find_invoice_by_invoice_id(id)
  end
end
