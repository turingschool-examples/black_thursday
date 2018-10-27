require 'pry'
require 'CSV'
require_relative './repository'

class TransactionRepository < Repository

  def new_record(row)
    Transaction.new(row)
  end

  def find_all_by_credit_card_number(credit_card_number)
    @repo_array.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end


end
