require 'csv'
require_relative 'transaction'
require 'bigdecimal'

class TransactionRepository

  def initialize(path, sales_engine = "")
    @transactions = {}
    @parent = sales_engine
    transaction_creator_and_storer(path)
  end

  def transaction_creator_and_storer(path)
    csv_opener(path).each do |transaction|
      new_transaction = Transaction.new(transaction, self)
      @transactions[new_transaction.id] = new_transaction
    end
  end

  def csv_opener(path = "./data/transactions.csv")
    CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    @transactions.values
  end

  def find_by_id(id)
    argument_raiser(id)
    @transactions[id]
  end

  def find_all_by_invoice_id(invoice_id)
    argument_raiser(invoice_id)
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

  def find_invoice_by_invoice_id(invoice_id)
    @parent.find_invoice_by_invoice_id(invoice_id)
  end

  def argument_raiser(data_type, desired_class = Integer)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
