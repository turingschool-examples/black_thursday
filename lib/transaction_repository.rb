require 'csv'
require_relative '../lib/transaction'

class TransactionRepository
  def initialize(parent)
    @transactions = Hash.new {|hash, invoice_id| hash[invoice_id] = []}
    @invoices = parent
  end

  def from_csv(file_path)
    transaction_data = CSV.open file_path, headers: true,
      header_converters: :symbol
    transaction_data.each do |row|
      @transactions[row[:invoice_id]] << Transaction.new(row.to_hash, self)
    end
  end

  def all
    return @transactions.values.flatten
  end

  def find_by_id(id)
    all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_invoice_id(invoice_id)
    @invoices.find_by_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
