require_relative 'transaction'
require_relative 'repository'

class TransactionRepository < Repository
  attr_reader :type, :attr_whitelist
  def initialize
    @type = Transaction
    @attr_whitelist = [:credit_card_number, :credit_card_expiration_date, :result]
    super
  end

  def find_all_by_credit_card_number(card_number)
    @instances.find_all { |transaction| transaction.credit_card_number == card_number}
  end

  def find_all_by_result(result)
    @instances.find_all { |transaction| transaction.result == result}
  end

  def find_all_by_invoice_id(invoice_id)
    @instances.find_all { |transaction| transaction.invoice_id == invoice_id}
  end

  def any_success?(invoice_id)
    find_all_by_invoice_id(invoice_id).any?{|tr| tr.result == :success}
  end
end
