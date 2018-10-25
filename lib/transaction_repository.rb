require_relative 'transaction'
require_relative 'repository'

class TransactionRepository < Repository
  attr_reader :type, :attr_whitelist
  def initialize
    @type = Transaction
    @attr_whitelist = [:credit_card_number, :credit_card_expiration_date, :result]
    super
  end

  def test_find_all_by_credit_card_number(card_number)
    @instances.find_all {|transaction| transaction.credit_card_number == card_number}
  end

  def test_find_all_by_result(result)
    @instances.find_all {|transaction| transaction.result == result}
  end
end
