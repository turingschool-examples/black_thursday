require_relative '../lib/invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepo

  attr_reader :all,
              :id,
              :customer_id,
              :invoice_id

  def initialize(file, sales_engine)
    @parent = sales_engine
    @all = []
    file_reader(file)
  end

 def file_reader(file)
    contents = CSV.open(file, headers:true, header_converters: :symbol)
    contents.each do |item|
       @all << InvoiceItem.new(item, self)
    end
  end

  def all
    #all - returns an array of all known InvoiceItem instances
    @all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id.to_i
      return invoice.customer_id.length
    end
  end

  def find_by_id(desired_id)
    #find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
    @all.find do |invoice|
      invoice.id == desired_id
    end
  end

  def find_all_by_item_id(id)
    #find_all_by_item_id - returns either [] or one or more matches which have a matching item ID
    @all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id.to_i
      return invoice.customer_id.length
    end
  end
  
  def find_all_by_invoice_id(invoice_id)
    #find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
    @all.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id.to_i
      return invoice.merchant_id.to_i
    end
  end
end