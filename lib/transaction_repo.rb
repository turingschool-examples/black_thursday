require_relative '../lib/transaction'
require 'csv'
require 'pry'

class TransactionRepo
  attr_reader :all,
              :id,
              :invoice_id,
              :credit_card_number,
              :result

  def initialize(file, sales_engine)
    @parent = sales_engine
    @all = []
    file_reader(file)
  end

 def file_reader(file)
    contents = CSV.open(file, headers:true, header_converters: :symbol)
    contents.each do |item|
       @all << Transaction.new(item, self)
    end
  end

  def find_by_id(desired_id)
    @all.find do |transaction|
      transaction.id == desired_id
      return transaction.invoice_id
      #not sure what it should return
    end
  end

  def find_by_invoice_id(desired_invoice_id)
    @all.find do |transaction| #or invoice, not sure
      invoice.id == desired_invoice_id
    end
  end

  def find_all_by_credit_card_number(desired_credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number.to_i == desired_credit_card_number.to_i
      return transaction
    end
  end
  
  def find_all_by_result(desired_result)
    @all.find_all do |transaction|
      transaction.result == desired_result
      return transaction
    end
  end
end
