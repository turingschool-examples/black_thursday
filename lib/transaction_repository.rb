require 'csv'
require './lib/transaction'
require './lib/repository_aide'
require './lib/time_helper'

class TransactionRepository
  include RepositoryAide
  include TimeHelper
  attr_reader :repository

  def initialize(file)
    @repository = read_csv(file).map do |transaction|
          Transaction.new({
            :id => transaction[:id],
            :invoice_id => transaction[:invoice_id],
            :credit_card_number => transaction[:credit_card_number],
            :credit_card_expiration_date => transaction[:credit_card_expiration_date],
            :result => transaction[:result],
            :created_at => create_time(transaction[:created_at]),
            :updated_at => transaction[:updated_at]
          })
        end
    group_hash
  end

  def group_hash
    @ids = @repository.group_by {|trans| trans.id}
    @invoice_ids = @repository.group_by {|trans| trans.invoice_id}
    @credit_card_numbers = @repository.group_by {|trans| trans.credit_card_number}
    @results = @repository.group_by {|trans| trans.result}
  end

  def find_all_by_credit_card_number(cc_num)
    find(@credit_card_numbers, cc_num)
  end

  def find_all_by_result(result)
    find(@results, result)
  end

  def create(attributes)
    transaction = Transaction.new({
      :id => new_id.to_s,
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
