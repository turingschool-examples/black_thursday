require 'time'
require 'pry'
require_relative './repo_methods'
require_relative './transaction'
require "csv"


class TransactionRepository
  include RepoMethods

  attr_reader :objects_array


  def initialize(file_path)
    @objects_array = transaction_csv_converter(file_path)
  end

  def transaction_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:invoice_id] = obj[:invoice_id].to_i
      obj[:credit_card_number] = obj[:credit_card_number]
      obj[:credit_card_expiration_date] = obj[:credit_card_expiration_date]
      obj[:result] = obj[:result].to_sym
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      Transaction.new(obj.to_h)
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_items_array.size} rows>"
  end

  def find_all_by_credit_card_number(credit_card_number)
    @objects_array.find_all do |object|
      object.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @objects_array.find_all do |object|
      object.result == result
    end
  end

  def create(attributes)
    max_id = generate_id
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
          :invoice_id => attributes[:invoice_id],
          :credit_card_number => attributes[:credit_card_number],
          :credit_card_expiration_date => attributes[:credit_card_expiration_date],
          :result => attributes[:result].to_sym,
          :created_at => time,
          :updated_at => time}
    @objects_array << Transaction.new(attributes)
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    attributes.each do |attribute, value|
      if attribute == :credit_card_number
        transaction.credit_card_number = value
        transaction.updated_at = Time.new.getutc
      elsif attribute == :credit_card_expiration_date
        transaction.credit_card_expiration_date = value
        transaction.updated_at = Time.new.getutc
      elsif attribute == :result
        transaction.result = value.to_sym
        transaction.updated_at = Time.new.getutc
      else
        'You can not modify this attribute'
      end
    end
  end
end
