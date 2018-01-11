require 'csv'
require_relative '../lib/transaction'

class TransactionRepository

  attr_reader :all,
              :parent

  def initialize(file_path, parent)
    contents = CSV.open(file_path, headers: true, header_converters: :symbol)
    @all = contents.map do |row|
      Transaction.new({
            :id => row[:id],
            :invoice_id => row[:invoice_id],
            :credit_card_number => row[:credit_card_number],
            :credit_card_expiration_date => row[:credit_card_expiration_date],
            :result => row[:result],
            :created_at => row[:created_at],
            :updated_at => row[:updated_at]},
            self)
    end
    @parent = parent
  end

  def find_by_id(id)
    all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.select do |transaction|
      transaction.result == result
    end
  end

  def call_invoice_from_invoice_id(invoice_id)
    parent.get_invoice_from_invoice_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
