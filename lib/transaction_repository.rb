require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
      @all.find_all { |transaction| transaction.invoice_id == invoice_id }
    end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_result(result)
    @all.find_all { |transaction| transaction.result == result }
  end

end
