require 'pry'
require './lib/findable'
require_relative '../lib/crudable'


class TransactionRepository
  include Findable
  include Crudable
  attr_reader :all

  def initialize(array)
    @all = array
    @new_object = Transaction
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |one|
      one.invoice_id.to_s.include?(invoice_id.to_s)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |one|
      one.credit_card_number.to_s.include?(credit_card_number.to_s)
    end
  end

  def find_all_by_result(result)
    @all.find_all do |one|
      one.result.include?(result)
    end
  end
end
