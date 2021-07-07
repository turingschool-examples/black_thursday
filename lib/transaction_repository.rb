require 'pry'

require_relative 'csv_parse'
require_relative 'transaction'
require_relative 'finder'


class TransactionRepository
  include Finder

  attr_reader :all,
              :transactions

  def initialize(path)
    @csv = CSVParse.create_repo(path)
    @all = []
    make_transactions
    @transactions = make_transactions
  end

  def make_transactions
    @csv.each { |key, value|
      transaction = Transaction.new({
        id: key.to_s.to_i,
        invoice_id: value[:invoice_id],
        credit_card_number: value[:credit_card_number],
        credit_card_expiration_date: value[:credit_card_expiration_date],
        result: value[:result],
        created_at: value[:created_at],
        updated_at: value[:updated_at]
      })
      @all << transaction
    }
    @all.flatten!
  end
end

