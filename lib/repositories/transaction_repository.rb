require_relative '../elementals/transaction'
require_relative 'repository'

# transaction_repository class
class TransactionRepository < Repository
  attr_reader :transactions

  def initialize(transactions_data)
    @transactions = create_index(Transaction, transactions_data)
    super(transactions, Transaction)
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.values.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.values.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_credit_card_expiration_date(date)
    @transactions.values.find_all do |transaction|
      transaction.credit_card_expiration_date.casecmp(date).zero?
    end
  end

  def find_all_by_result(req_result)
    @transactions.values.find_all do |transaction|
      transaction.result == req_result
    end
  end

  def update(id, attrs)
    t = @transactions
    ccn = :credit_card_number
    exp_date = :credit_card_expiration_date
    return unless t[id]
    t[id].credit_card_number = attrs[ccn] if attrs[ccn]
    t[id].credit_card_expiration_date = attrs[exp_date] if attrs[exp_date]
    t[id].result = attrs[:result].to_sym if attrs[:result]
    t[id].updated_at = Time.now
  end
end
