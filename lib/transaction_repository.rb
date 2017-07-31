require 'pry'
require 'csv'
require_relative '../lib/transaction'

class TransactionRepository

  attr_reader :transactions

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @transactions = []
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all {|transaction| transaction.invoice_id == id}
  end

  def find_all_by_credit_card_number(cc)
    @transactions.find_all {|transaction| transaction.credit_card_number == cc}
  end

  def find_all_by_result(result)
    @transactions.find_all {|transaction| transaction.result == result}
  end

  def from_csv(path)
    rows = CSV.open path, headers: true, header_converters: :symbol
    rows.each do |data|
      add_data(data)
    end
  end

  def add_data(data)
    @transactions << Transaction.new(data.to_hash, @sales_engine)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  # def find_all_by(query, arg, branch)
  #   result = []
  #   repo = get_instance_of(branch)
  #   repo.each do |instance|
  #     if instance.arg == query
  #       result << instance
  #     end
  #   result
  #   end
  # end

end
