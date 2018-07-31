require 'csv'
require_relative '../lib/transaction.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class TransactionRepository
  attr_reader :list
  include RepoMethodHelper

  def initialize(list)
    @list = list
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |each|
      each.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |each|
      each.result == result.to_sym
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    created = Transaction.new(attributes)
    @list << created
    created
  end

  def update(id, attributes)
    find_by_id(id).result = attributes[:result].to_sym unless attributes[:result].nil?
    find_by_id(id).credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    find_by_id(id).credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end
end
