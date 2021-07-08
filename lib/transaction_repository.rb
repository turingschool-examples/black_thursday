require 'csv'
require_relative "transaction"

class TransactionRepository

  attr_reader :all,
              :sales_engine

  def initialize(parent = nil)
    @all = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def populate(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id.to_i == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number.to_i == credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result.downcase.include?(result.downcase)
    end
  end

  def find_by_invoice_id(invoice_id)
    @sales_engine.find_by_invoice_id(invoice_id)
  end

end
