require_relative '../lib/transaction'
require 'csv'
require 'pry'

class TransactionRepo
  attr_reader :all,
              :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

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
    end
  end

  def find_by_invoice_id(desired_invoice_id)
    @all.find do |invoice| 
      invoice.invoice_id == desired_invoice_id.to_i
    end
  end

  def find_all_by_invoice_id(desired_invoice_id)
    @all.find_all do |invoice| 
      invoice.invoice_id == desired_invoice_id.to_i
    end
  end

  def find_all_by_credit_card_number(desired_credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number == desired_credit_card_number.to_i
    end
  end
  
  def find_all_by_result(desired_result)
    @all.find_all do |transaction|
      transaction.result == desired_result
    end
  end

  def find_invoice_for_transaction(invoice_id)
    @parent.find_invoice_for_transaction(invoice_id)
  end

end
