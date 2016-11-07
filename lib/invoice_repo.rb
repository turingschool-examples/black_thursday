require_relative '../lib/invoice'
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
    CSV.foreach(file, headers:true, header_converters: :symbol) do |row|
       @all << Invoice.new(row, self)
    end
  end

  def find_by_id(desired_id)
    @all.find do |invoice|
      invoice.id == desired_id
    end
  end

  def find_all_by_customer_id(customer_id)
    all = @all.find_all do |invoice|
      invoice.customer_id.to_i == customer_id.to_i
    end
    all
  end

  def find_all_by_status(desired_status)
    i = @all.find_all do |invoice|
      invoice.status.downcase == desired_status.downcase
    end
    i
  end

  def find_merchant_by_id(merchant_id)
    @parent.find_merchant_for_invoice(merchant_id)
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id.to_i
    end
  end

  def find_items_for_invoice(item_id)
    @parent.find_items_for_invoice(item_id)
  end

  def find_invoice_items(id)
    @parent.find_invoice_items(id)
  end
  
  # def find_customer_from_invoice(customer_id)
  #   # @parent.something there to find customer from invoice
  # end


end