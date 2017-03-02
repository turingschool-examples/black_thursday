require_relative '../lib/transaction'
require 'pry'
class TransactionRepository

  attr_reader :all, :engine
  def initialize(file_input = nil, engine ="")
    @all    = []
    @engine = engine
    from_csv(file_input) if !file_input.nil?
  end

  def from_csv(info)
    CSV.foreach(info, headers: true, header_converters: :symbol) do |row|
      all <<  Transaction.new(row, self)
    end
  end

  def find_by_id(id_num)
    all.find {|transaction| transaction.id == id_num}
  end

  def find_all_by_invoice_id(invoice_num)
    all.select {|transaction| transaction.invoice_id == invoice_num}
  end

  def find_all_by_credit_card_number(credit_num)
    all.select {|transaction| transaction.credit_card_number == credit_num}
  end

  def find_all_by_result(approval)
    all.select {|transaction| transaction.result == approval}
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
