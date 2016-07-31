require_relative "../lib/transaction"
require "csv"
require 'pry'

class TransactionRepository
attr_reader :all

  def initialize(data_path, sales_engine = nil)
    @sales_engine = sales_engine
    @all = []
    csv_loader(data_path)
    transaction_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def transaction_maker
    @all = @csv.map do |row|
      Transaction.new(row, self)
    end
  end

  def find_by_id(id_input)
    @all.find do |instance|
      instance.id == id_input.to_i
    end
  end

  def find_all_by_invoice_id(invoice_id_input)
    @all.find_all do |instance|
      instance.invoice_id == invoice_id_input.to_i
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |instance|
      instance.credit_card_number == (credit_card_number)
    end
  end

  def find_all_by_result(result_input)
    @all.find_all do |instance|
      instance.result == result_input
    end
  end





  def inspect
  end
end
