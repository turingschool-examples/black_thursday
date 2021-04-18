require_relative './invoices'
require 'time'
require 'csv'
require 'bigdecimal'

class InvoiceRepo
  attr_reader :invoice_list

  def initialize(csv_files, engine)
    @invoice_list = invoice_instances(csv_files)
    @engine    = engine
  end

  def invoice_instances(csv_files)
    invoices = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @invoice_list = invoices.map do |invoice|
      Invoice.new(invoice, self)
    end
  end

  def all
    @invoice_list
  end

  def find_by_id(id)
    @invoice_list.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @all_by_customer_id = @invoice_list.find_all do |invoice|
      invoice.customer_id == id
    end
    customer_id_check
  end

  def find_all_by_merchant_id(id)
    @all_by_merchant_id = @invoice_list.find_all do |invoice|
      invoice.merchant_id == id
    end
    merchant_id_check
  end

  def customer_id_check
    if @all_by_customer_id == []
      nil
    else
      @all_by_customer_id
    end
  end

  def merchant_id_check
    if @all_by_merchant_id == []
      nil
    else
      @all_by_merchant_id
    end
  end
end
