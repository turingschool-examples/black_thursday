require 'time'
require_relative 'reposable'
require_relative 'transaction'

class TransactionRepository
  include Reposable

  def initialize(all = [])
    @all = all
  end

  def find_all_by_invoice_id
  end

  def find_all_by_credit_card_number
  end

  def find_all_by_result
  end

  def create
  end

  def update
  end
end