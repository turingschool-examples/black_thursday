require_relative 'transaction'
require 'pry'

class TransactionRepository

  attr_reader   :parent,
                :all

  def initialize(load_path = nil)
    @parent = parent
  end

  # binding.pry
  def populate(transaction_list)
    @all = transaction_list.map { |transaction| Transaction.new(transaction, self) }
  end

  def find_by_id(id)
    all.find { |transaction| transaction.id.eql?(id) }
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |transaction| transaction.invoice_id.eql?(invoice_id) }
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all { |transaction| transaction.credit_card_number.eql?(credit_card_number) }
  end

  def find_all_by_result(result)
    all.find_all { |transaction| transaction.result.eql?(result) }
  end

  def from_csv(file_path)
    transaction_item = {}
    if file_path != nil
      transaction_item = CSV.read file_path, headers:true, header_converters: :symbol
    else
      raise ArgumentError
    end
   populate(transaction_item)
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end
end