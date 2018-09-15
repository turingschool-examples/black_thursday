require 'pry'
require 'time'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/transaction'


class TransactionRepo
  include BlackThursdayHelper

  def initialize(filepath)
    @collections = []
    populate(filepath)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << Transaction.new(params)
    end
  end

  def find_all_by_credit_card_number(credit_number)
    @collections.find_all do |object|
      object.credit_card_number == credit_number
    end
  end

  def create(params)
    transaction = Transaction.new(params)
    new_highest_current = object_id_counter.id + 1
    transaction.id = new_highest_current
    @collections << transaction
    transaction
  end



end
