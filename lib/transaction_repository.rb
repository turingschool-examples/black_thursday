require_relative '../lib/transaction'
require_relative 'repository'

# transaction_repository class
class TransactionRepository < Repository
  attr_reader :transactions

  def initialize(csv_parsed_array)
    attributes = csv_parsed_array.map do |transaction|
      { id: transaction[0].to_i,
        invoice_id: transaction[1].to_i,
        credit_card_number: transaction[2].to_i,
        credit_card_expiration_date: transaction[3],
        result: transaction[4],
        created_at: transaction[4],
        updated_at: transaction[5] }
    end
    @transactions = create_index(Transaction, attributes)
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
      transaction.result.casecmp(req_result).zero?
    end
  end

  def update(id, attrs)
    return unless @transactions[id]
    @transactions[id].credit_card_number = attrs[:credit_card_number] if attrs[:credit_card_number]
    @transactions[id].credit_card_expiration_date = attrs[:credit_card_expiration_date] if attrs[:credit_card_expiration_date]
    @transactions[id].result = attrs[:result] if attrs[:result]
    @transactions[id].updated_at = Time.now
  end
end
