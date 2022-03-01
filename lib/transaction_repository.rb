require './lib/sales_engine'
require './lib/sales_analyst'
require 'pry'
require 'csv'
require 'date'
require_relative 'transaction'
require_relative 'sales_module'

class TransactionRepository
  include SalesModule
  attr_reader :all
  def initialize(csv)
    @all = Transaction.read_file(csv)
  end

  def find_all_by_invoice_id(id)
    @all.find_all{|trans| trans.invoice_id == id}
  end

  def find_all_by_credit_card_number(cc_num)
    found = []
    found << @all.find_all{|trans| trans.credit_card_number == cc_num}
    found.flatten
  end

  def find_all_by_result(result)
    found = []
    found << @all.find_all{|trans| trans.result == result}
    found.flatten
  end

  def create(data)
    new_item = Transaction.new({
      id: (@all[-1].id + 1),
      invoice_id: data[:invoice_id].to_i,
      credit_card_number: data[:credit_card_number],
      credit_card_expiration_date: data[:credit_card_expiration_date],
      result: data[:result],
      created_at: Time.now,
      updated_at: Time.now})
      @all << new_item
  end

  def update(id, attributes)
    updated_item = @all.find{|trans| trans.id == id}
    updated_item.credit_card_number = attributes[:credit_card_number] if attributes.keys.include?(:credit_card_number)
    updated_item.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes.keys.include?(:credit_card_expiration_date)
    updated_item.result = attributes[:result] if attributes.keys.include?(:result)
    updated_item.updated_at = Time.now
  end

end
