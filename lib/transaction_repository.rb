require_relative 'transaction'
require 'pry'

class TransactionRepository

  attr_reader :transactions,
              :se

  def initialize(transactions_path, se)
    @se = se
    @transactions = []
    contents = CSV.open transactions_path,
                        headers: true,
                        header_converters: :symbol
    contents.each do |row|
      id = (row[:id]).to_i
      invoice_id = row[:invoice_id].to_i
      credit_card_number = row[:credit_card_number]
      credit_card_expiration_date = row[:credit_card_expiration_date]
      result = row[:result].to_sym
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      transaction = Transaction.new(id, invoice_id,
                                    credit_card_number, credit_card_expiration_date,
                                    result, created_at, updated_at, self)
      @transactions << transaction
    end
  end

  def all
    @transactions
  end
end
