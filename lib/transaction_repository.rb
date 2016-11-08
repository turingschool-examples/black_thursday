require_relative 'transaction'
require 'pry'

class TransactionRepository

  attr_reader   :parent,
                :all

  def initialize(transaction_list, parent = nil)
    @parent = parent
    @all = populate(transaction_list)
  end

  def populate(transaction_list)
    transaction_list.map { |transaction| Transaction.new(transaction, self) }
  end

  def find_by_id(id)
    result = all.find_all { |transaction| transaction.id.eql?(id) }
    result[0]
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

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end
end