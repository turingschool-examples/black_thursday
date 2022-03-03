require 'csv'
require_relative '../lib/transaction'
require_relative '../lib/repository_aide'
require_relative '../lib/time_helper'

class TransactionRepository
  include RepositoryAide
  include TimeHelper
  attr_reader :repository, :invoice_ids

  def initialize(file)
    @repository = read_csv(file).map do |transaction|
          Transaction.new({
            :id => transaction[:id].to_i,
            :invoice_id => transaction[:invoice_id].to_i,
            :credit_card_number => transaction[:credit_card_number],
            :credit_card_expiration_date => transaction[:credit_card_expiration_date],
            :result => transaction[:result].to_sym,
            :created_at => transaction[:created_at],
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

  def find_all_by_invoice_id(invoice_id)
    find(@invoice_ids, invoice_id)
  end

  def find_all_by_credit_card_number(cc_num)
    find(@credit_card_numbers, cc_num)
  end

  def find_all_by_result(result)
    find(@results, result)
  end

  def create(attributes)
    transaction = Transaction.new(create_attribute_hash(attributes))
    @repository << transaction
    transaction
  end
end
