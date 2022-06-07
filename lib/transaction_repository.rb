require 'csv'
require_relative 'transaction'

class TransactionRepository
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

  def create(attributes)
    new_id = 0
    @all.each do |transaction|
      if transaction.id.to_i >= new_id
        new_id = transaction.id.to_i + 1
      end
    end
    @all << Transaction.new( {
      :id => new_id.to_s,
      :invoice_id => attributes[:invoice_id],
      :credit_card_number => attributes[:credit_card_number],
      :credit_card_expiration_date => attributes[:credit_card_expiration_date],
      :result => attributes[:result],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
      } )
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

  def delete(transaction_id_search)
    @all.find do |transaction|
      transaction.id == transaction_id_search
      @all.delete(transaction)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
