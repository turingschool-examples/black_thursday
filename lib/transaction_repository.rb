require_relative '../module/incravinable'

class TransactionRepository

  include Incravinable

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  attr_reader :all,
              :engine

  def initialize(path, engine)
    @all = []
    create_transactions(path)
    @engine = engine
  end

  def create_transactions(path)
    transactions = CSV.foreach(path, headers: true, header_converters: :symbol) do |transaction_data|
      transaction_hash = {
                  id: transaction_data[:id].to_i,
                  invoice_id: transaction_data[:invoice_id].to_i,
                  credit_card_number: transaction_data[:credit_card_number].to_i,
                  credit_card_expiration_date: transaction_data[:credit_card_expiration_date],
                  result: transaction_data[:result],
                  created_at: transaction_data[:created_at],
                  updated_at: transaction_data[:updated_at]
                }

    @all << Transaction.new(transaction_hash, self)
    end
  end





end
