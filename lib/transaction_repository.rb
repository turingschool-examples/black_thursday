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
      @all << Transaction.new({
        :id => row[:id].to_i,
        :invoice_id => row[:invoice_id].to_i,
        :credit_card_number => row[:credit_card_number],
        :credit_card_expiration_date => row[:credit_card_expiration_date],
        :result => row[:result],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
    end
  end

  def find_by_id(id_search)
    @all.find do |transaction|
      transaction.id == id_search
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

  def update(transaction_id_search, new_credit_card_number, new_credit_card_expiration_date, new_result)
    @all.find do |transaction|
      if transaction.id == transaction_id_search
        transaction.credit_card_number = new_credit_card_number
        transaction.credit_card_expiration_date = new_credit_card_expiration_date
        transaction.result = new_result
        transaction.updated_at = Time.now
      end
    end
  end
end
