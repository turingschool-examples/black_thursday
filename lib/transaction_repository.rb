require 'csv'
require './lib/transaction'
require './lib/repository_aide'

class TransactionRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    @transactions = CSV.read(file, headers: true, header_converters: :symbol)

    @repository = @transactions.map do |transaction|
          Transaction.new({
            :id => transaction[:id],
            :invoice_id => transaction[:invoice_id],
            :credit_card_number => transaction[:credit_card_number],
            :credit_card_expiration_date => transaction[:credit_card_expiration_date],
            :result => transaction[:result],
            :created_at => transaction[:created_at],
            :updated_at => transaction[:updated_at]
          })
        end
  end

  def find_all_by_credit_card_number(cc_num)
    @repository.select do |transaction|
      transaction.credit_card_number == cc_num
    end
  end


end
