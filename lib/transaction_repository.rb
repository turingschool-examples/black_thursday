require 'csv'
require_relative 'transaction'
require_relative 'parser'

class TransactionRepository
  include Parser
  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    @all    = create_transactions(file_path)
    @parent = parent
  end

  def create_transactions(file_path)
    data_rows = parse_transactions_csv(file_path)
    data_rows.map { |row| Transaction.new(row, self) }
  end

  def find_by_id(desired_id)
    all.find {|t| t.id == desired_id}
  end

  def find_all_by_invoice_id(desired_id)
    all.find_all {|t| t.invoice_id == desired_id}
  end

  def find_all_by_credit_card_number(desired_number)
    all.find_all {|t| t.credit_card_number == desired_number}
  end

  def find_all_by_result(desired_result)
    all.find_all {|t| t.result == desired_result}
  end

  def find_invoice_by_invoice_id(invoice_id)
    parent.find_invoice_by_invoice_id(invoice_id)
  end

  def inspect
    '#{self.class}, #{all.count}'
  end

end