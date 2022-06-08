require 'csv'
require_relative 'transaction'
require_relative 'inspector'

class TransactionRepository
  include Inspector
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row)
    end
  end

  def find_all_by_invoice_id(invoice_id_search)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id_search
    end
  end

  def find_all_by_credit_card_number(credit_card_number_search)
    @all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number_search
    end
  end

  def find_all_by_result(result_search)
    @all.find_all do |transaction|
      transaction.result == result_search
    end
  end
end
