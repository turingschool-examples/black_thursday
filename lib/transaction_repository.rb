require 'csv'
require 'bigdecimal'
require 'time'
require_relative './repository_module'

class TransactionRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def split(filepath)
    objects = CSV.open(filepath, headers: true, header_converters: :symbol)

    attributes_array = []
    objects.map do |object|
      object[:id] = object[:id].to_i

      object[:invoice_id] = object[:invoice_id].to_i

      object[:credit_card_number] = object[:credit_card_number].to_s

      object[:result] = object[:result].to_sym

      object[:created_at] = Time.parse(object[:created_at])

      object[:updated_at] = Time.parse(object[:updated_at])
      attributes_array << object.to_h
    end

    attributes_array.each do |hash|
      create(hash)
    end
  end

  def all
    @all
  end

  def find_all_by_invoice_id(invoice_id)
      @all.find_all do |object|
        object.invoice_id == invoice_id
      end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |object|
      object.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |object|
      object.result == result
    end
  end

  def create(attributes)
    is_included = @all.any? do |transaction|
      attributes[:id] == transaction.id
    end
    has_id = attributes[:id] != nil
    is_included = false if @all == []
    if has_id && !is_included
      @all << Transaction.new(attributes)
    elsif @all == []
      new_id = 1
      attributes[:id] = new_id
      @all << Transaction.new(attributes)
    else
      highest_id = @all.max_by do |transaction|
        transaction.id
      end.id
      new_id = highest_id + 1
      attributes[:id] = new_id
      @all << Transaction.new(attributes)
    end
  end

  def inspect
   "#<#{self.class} #{@transactions.size} rows>"
  end

end
