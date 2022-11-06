require 'time'
require_relative 'reposable'
require_relative 'transaction'

class TransactionRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      invoice_id.to_i == transaction.invoice_id.to_i
    end
  end
  #this is a repeated test, maybe reposable?

  def find_all_by_credit_card_number(card_num)
    all.find_all do |transaction|
      card_num == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      
      result == transaction.result
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end