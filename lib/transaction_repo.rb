require "csv"
require_relative "../lib/transaction"

class TransactionRepo

  def initialize
    @transaction_objects = []
  end

  def from_csv(filepath)
    contents = CSV.open filepath, headers: true, header_converters: :symbol
      @transaction_objects = contents.map do |row|
      Transaction.new(row, self)
    end
  end

  def all
    @transaction_objects
  end

  def find_by_id(transaction_id)
    @transaction_objects.detect do |transaction|
      transaction.id == transaction_id
    end
  end

  def find_all_by_id(id_fragment)
    @transaction_objects.select do |transaction|
      transaction.invoice_id.to_s.include?(id_fragment.to_s)
    end
  end

  def find_all_by_credit_card_number(credit_card_fragment)
    @transaction_objects.select do |transaction|
      transaction.credit_card_number.include?(credit_card_fragment)
    end
  end

  def find_all_by_result(result)
    @transaction_objects.select do |transaction|
      transaction.result.include?(result)
    end
  end

end
