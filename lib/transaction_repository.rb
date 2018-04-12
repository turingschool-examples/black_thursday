require_relative '../lib/transaction'
require_relative 'repository'

# transaction_repository class
class TransactionRepository < Repository
  attr_reader :transactions

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
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
    @transactions.values.map do |transaction|
      transaction if transaction.invoice_id == invoice_id
    end.compact
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.values.map do |transaction|
      transaction if transaction.credit_card_number == credit_card_number
    end.compact
  end

  def find_all_by_credit_card_expiration_date(date)
    @transactions.values.map do |transaction|
      transaction if transaction.credit_card_expiration_date.casecmp(date).zero?
    end.compact
  end

  def find_all_by_result(req_result)
    @transactions.values.map do |transaction|
      transaction if transaction.result.casecmp(req_result).zero?
    end.compact
  end

  def update(id, attributes)
    if @transactions[id]
      @transactions[id].credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
      @transactions[id].credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
      @transactions[id].result = attributes[:result] if attributes[:result]
      @transactions[id].updated_at = Time.now
    end
  end
end
