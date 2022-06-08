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

  def assign_attributes(transaction, attributes)
    transaction.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    transaction.result = attributes[:result] unless attributes[:result].nil?
    transaction.updated_at = Time.now
    transaction
  end

  def update (id, attributes)
    @all.each do |transaction|
      if transaction.id == id
        assign_attributes(transaction, attributes)
      end
    end
  end
end
