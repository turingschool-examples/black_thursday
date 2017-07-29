require 'pry'
require 'csv'
require_relative '../lib/transaction'

class TransactionRepository

  attr_reader :transactions

  def initialize(sales_engine = self)
    @sales_engine = sales_engine
    @transactions = []
  end

  def all
    @transactions
  end

  def find_by_id(id)
    result = nil
    @transactions.each do |transaction|
      if transaction.id == id
        result = transaction
      end
    end
    result
  end

  def find_all_by_invoice_id(id)
    result = []
    @transactions.each do |transaction|
      if transaction.invoice_id == id
        result << transaction
      end
    end
    result
  end

  def find_all_by_credit_card_number(cc)
    result = []
    @transactions.each do |transaction|
      if transaction.credit_card_number == cc
        result << transaction
      end
    end
    result
  end

  def find_all_by_results(result_return)
    result = []
    @transactions.each do |transaction|
      if transaction.result == result_return
        result << transaction
      end
    end
    result
    #find_all_by(result, "result", @transactions)
  end

  def from_csv(path)
    rows = CSV.open path, headers: true, header_converters: :symbol
    rows.each do |content|
      @transactions << Transaction.new(content.to_hash)
    end
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


# tr = TransactionRepository.new
# tr.from_csv("./data/transactions.csv")
# binding.pry
