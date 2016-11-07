require_relative 'find_functions'
require_relative 'transaction'
require 'csv'

class TransactionRepository

  include FindFunctions

  attr_reader :file_contents,
              :all,
              :parent

  def initialize(file_name = nil, engine = nil)
    return unless file_name
    @parent        = engine
    @file_contents = load(file_name)
    @all           = create_transaction_objects
  end

  def inspect
    "#<#{self.class}: #{@all.count} rows>"
  end

  def load(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def create_transaction_objects
    @file_contents.map { |row| Transaction.new(row, self) }
  end

  def find_invoice_by_id(invoice_id)
    parent.find_invoice_by_id(invoice_id)
  end

  def find_by_id(id)
    find_by(:id, id)
  end

  def find_all_by_invoice_id(invoice_id)
    find_all(:invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all(:credit_card_number, credit_card_number)
  end

  def find_all_by_result(result)
    find_all(:result, result)
  end

end
