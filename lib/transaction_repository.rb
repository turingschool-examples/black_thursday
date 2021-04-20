require 'csv'
require_relative 'repository'
require_relative 'transaction'
require 'time'

class TransactionRepository < Repository
  def initialize(location_hash, engine)
    super(location_hash, engine)
    all_transactions
  end

  def all_transactions
    @csv_array = []
    CSV.parse(File.read(@location_hash[:transactions]), headers: true).each do |transaction|
      @csv_array << Transaction.new(
        id:                           transaction[0],
        invoice_id:                   transaction[1],
        credit_card_number:           transaction[2],
        credit_card_expiration_date:  transaction[3],
        result:                       transaction[4],
        created_at:                   Time.parse(transaction[5]),
        updated_at:                   Time.parse(transaction[6]),
        repository:                   self
      )
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @csv_array.find_all do |transaction_test|
      transaction_test.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @csv_array.find_all do |transaction_test|
      transaction_test.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @csv_array.find_all do |transaction_test|
      transaction_test.result == result
    end
  end

  def create(transaction_hash)
    attributes = {
      id: max_id_number_new,
      invoice_id: transaction_hash[:invoice_id].to_i,
      credit_card_number: transaction_hash[:credit_card_number],
      credit_card_expiration_date: transaction_hash[:credit_card_expiration_date],
      result: transaction_hash[:result].to_sym,
      created_at: Time.now,
      updated_at: Time.now,
      repository: self
    }
    @csv_array << Transaction.new(attributes)
    Transaction.new(attributes)
  end

  # def transactions_by_invoice
  #   hash = @csv_array.group_by do |transaction|
  #     transaction.invoice_id
  #   end
  #   test = hash.map do |key|
  #     require "pry"; binding.pry
  #     hash[key] unless hash[key].include?(:success)
  #   end
  # end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
    # should this be @merchants or @invoices
    # same with item repo
  end
end
