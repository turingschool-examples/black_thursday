require 'pry'
require './lib/findable'

class TransactionRepository
  include Findable
  attr_reader :all

  def initialize(array)
    @all = array
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

  def find_all_by_item_id

  end




end
