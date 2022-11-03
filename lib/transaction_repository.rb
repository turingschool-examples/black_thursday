require 'time'
require_relative 'reposable'
require_relative 'transaction'

class TransactionRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      invoice_id.to_i == transaction.invoice_id.to_i
    end
  end
  #this is a repeated test, maybe reposable?

  def find_all_by_credit_card_number(card_num)
    all.find_all do |transaction|
      card_num == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      result == transaction.result
    end
  end

  def create(attributes)
    all << Transaction.new({ :id                           => attributes[:id],
                             :invoice_id                   => attributes[:invoice_id],
                             :credit_card_number           => attributes[:credit_card_number],
                             :credit_card_expiration_date  => attributes[:credit_card_expiration_date],
                             :result                       => attributes[:result],
                             :created_at                   => attributes[:created_at],
                             :updated_at                   => attributes[:updated_at]
                           })
  end

  def update(attributes)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end