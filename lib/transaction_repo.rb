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

# check the transaction Id, it breaks if I take away an =
  def create(params)
    transaction = Transaction.new(params)
    new_highest_current = object_id_counter.id + 1
    transaction.id == new_highest_current
    @collections << transaction
    transaction
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      object_to_be_updated = find_by_id(id)
      # object_to_be_updated.name = attributes[:name]
      object_to_be_updated.credit_card_number = attributes[:credit_card_number]
      object_to_be_updated.credit_card_expiration_date = attributes[:credit_card_expiration_date]
      object_to_be_updated.result = attributes[:result]
      object_to_be_updated.updated_at = Time.now
    else
      nil
    end
  end
end
