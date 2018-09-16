require 'CSV'
require_relative 'csv_adapter'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

require_relative 'transaction.rb'
require_relative 'crud.rb'

class TransactionRepository
include Crud

  attr_reader :collection,
              :changeable_attributes

  def initialize(filepath)
    @collection = []
    loader(filepath)
    @changeable_attributes = [:credit_card_number,
      :credit_card_expiration_date, :result]
  end

  def create(attributes)
    if @collection != []
      largest = (@collection.max_by {|element| element.id})
      attributes[:id] = (largest.id + 1)
    else
      attributes[:id] = 1
    end
    i = Transaction.new(attributes)
    @collection << i
  end

  def find_all_by_id(number)
    find_all_by_exact("id", number)
  end

  def find_all_by_invoice_id(number)
    find_all_by_exact("invoice_id", number)
  end

  def find_all_by_credit_card_number(string)
    find_all_by_exact("credit_card_number", string)
  end

  def find_all_by_result(string)
    find_all_by_exact("result", string)
  end

  def all
    @collection
  end

  def loader(filepath)
    item_table = load(filepath)
     item_table.map do |item|
       item[:id]                          = item[:id].to_i
       item[:invoice_id]                  = item[:invoice_id].to_i
       item[:credit_card_number]          = item[:credit_card_number]
       item[:credit_card_expiration_date] = item[:credit_card_expiration_date]
       item[:result]                      = item[:result]
       item[:updated_at]                  = Time.parse(item[:updated_at])
       item[:created_at]                  = Time.parse(item[:created_at])
     @collection << Transaction.new(item)
     end
   end

   def update(id, attributes)
     if find_by_id(id) != nil
       it = collection.find { |element| element.id == id }
        it.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number] != nil
        it.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date] != nil
        it.result = attributes[:result] if attributes[:result] != nil
        it.updated_at = Time.now
     else
       []
     end
   end

end
