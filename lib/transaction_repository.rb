require 'csv'
require './lib/transaction'
require './lib/repository_aide'

class TransactionRepository
  include RepositoryAide
  attr_reader :repository

  def initialize(file)
    # @transactions = CSV.read(file, headers: true, header_converters: :symbol)

    @repository = read_csv(file).map do |transaction|
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

  def find_all_by_result(result)
    @repository.select do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    transaction = Transaction.new({
      :id => new_id,
      :invoice_id => attributes[:invoice_id],
      :credit_card_number => attributes[:credit_card_number],
      :credit_card_expiration_date => attributes[:credit_card_expiration_date],
      :result => attributes[:result],
      :created_at => Time.now,
      :updated_at => Time.now})

    @repository << transaction
    transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    transaction.credit_card_number = attributes[:credit_card_number]
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date]
    transaction.result = attributes[:result]
    transaction.updated_at = Time.now
  end

end
