require 'time'
require_relative 'reposable'
require_relative 'transaction'

class TransactionRepository
  include Reposable

  def initialize(all = [])
    @all = all
  end

  def find_all_by_invoice_id(invoice_id)
  end

  def find_all_by_credit_card_number(card_num)
  end

  def find_all_by_result(result)
  end

  def create(attributes)
  end

  def update(attributes)
  end
end