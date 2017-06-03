require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'invoice'
require 'pry'

class InvoiceRepository
  attr_reader :all,
              :sales_engine

  def initialize(file, sales_engine)
    @sales_engine = sales_engine
    @all = []
    populate_invoice_repo(file)
  end

  def populate_invoice_repo(file)
    invoice_lines = CSV.open(file, headers: true, header_converters: :symbol)
    invoice_lines.each do |row|
      invoice = Invoice.new(row, self)
      all << invoice
    end
    invoice_lines.close
  end

  def find_by_id(id)
    all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    final = all.find_all do |invoice|
      invoice.id == customer_id
    end
    final
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |id|
      id.merchant_id == merch_id
    end
  end

  def find_all_by_status(in_status)
    all.find_all do |sta|
      sta.status == in_status
    end
  end

  def merchant(merchant_id)
    @sales_engine.merchant(merchant_id)
  end

end
