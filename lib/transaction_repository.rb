require_relative 'transaction'
require_relative 'sales_engine'
require 'csv'

class TransactionRepository

  attr_reader :all, :transactions, :sales_engine

  def initialize(sales_engine, item_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      all << Transaction.new(self, row)
    end
  end

  def find_by_id(id)
    all.each do |transaction|
      return transaction if transaction.id.to_i == id
    end
    nil
  end

  def find_all_by_invoice_id(invoice_id)
    all.select {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.select {|transaction| transaction.result == result}
  end

  def inspect
    "#<#{self.class} #{:transactions.size} rows>"
  end

end
