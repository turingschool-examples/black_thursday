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
    all.find_all do |invoice_item|
      invoice_id.to_i == invoice_item.invoice_id.to_i
    end
  end
  #this is a repeated test, maybe reposable?

  def find_all_by_credit_card_number(card_num)
    all.find_all do |transaction_item|
      card_num == transaction_item.card_num
    end
  end

  def find_all_by_result(result)
  end

  def create(attributes)
  end

  def update(attributes)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end