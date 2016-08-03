require "csv"
require_relative "../lib/transaction"

class TransactionRepo

  def initialize(csv_filepath, parent = nil)
    contents = CSV.open csv_filepath, headers: true, header_converters: :symbol
    @transaction_objects = contents.map do |row|
      Transaction.new(row, self)
    end
    @parent = parent
    # @transaction_objects = []
  end

  # def from_csv(filepath)
  #   contents = CSV.open filepath, headers: true, header_converters: :symbol
  #     @transaction_objects = contents.map do |row|
  #     Transaction.new(row, self)
  #   end
  # end

  def all
    @transaction_objects
  end

  def find_by_id(transaction_id)
    @transaction_objects.detect do |transaction|
      transaction.id == transaction_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transaction_objects.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card)
    @transaction_objects.select do |transaction|
      transaction.credit_card_number == credit_card
    end
  end

  def find_all_by_result(result)
    @transaction_objects.select do |transaction|
      transaction.result.include?(result)
    end
  end

  def find_invoice_by_id(invoice_id)
    @parent.find_invoice_by_id(invoice_id)
  end
end
