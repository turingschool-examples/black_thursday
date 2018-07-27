require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class TransactionRepository
  include Repository

  def initialize(transaction_items)
    @list = transaction_items
  end

  def find_all_by_invoice_id(id)
    @list.find_all do |invoice|
      invoice.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(card_number)
    @list.find_all do |credit_card|
      credit_card.credit_card_number == card_number
    end
  end
end
