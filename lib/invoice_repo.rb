require './lib/invoice'
require 'csv'
require 'pry'

class InvoiceRepo
  attr_reader :all,
              :id,
              :customer_id,
              :merchant_id,
              :status,
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
       @all << Invoice.new(item, self)
    end
  end

  def find_by_id(desired_id)
    @all.find do |invoice|
      invoice.id == desired_id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id.to_i
      return invoice.customer_id.length
    end
  end

  def find_all_by_status(desired_status)
    @all.find_all do |invoice|
      invoice.status.downcase == desired_status.downcase
      return invoice.status.length
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id.to_i
      return invoice.merchant_id.to_i
    end
  end


end