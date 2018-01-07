require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices,
              :parent

  def initialize(path, sales_engine = "")
    @invoices = {}
    @parent = sales_engine
    invoice_creator_and_storer(path)
  end

  def invoice_creator_and_storer(path)
    csv_opener(path)
    csv_opener(path).each do |invoice|
      new_invoice = Invoice.new(invoice, self)
      @invoices[new_invoice.id.to_i] = new_invoice
    end
  end

  def csv_opener(path = "./data/invoices.csv")
    CSV.open path, headers: true, header_converters: :symbol
  end

  def all
    @invoices.values
  end

  def find_by_id(id)
    argument_raiser(id)
    @invoices[id]
  end

  def find_all_by_customer_id(id)
    argument_raiser(id)
    all.select do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    argument_raiser(id)
    all.select do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    argument_raiser(status, Symbol)
    all.select do |invoice|
      invoice.status == status
    end
  end

  def merchant(id)
    argument_raiser(id)
    @parent.find_merchant_by_id(id)
  end

  def argument_raiser(data_type, desired_class = Integer)
    if data_type.class != desired_class
      raise ArgumentError
    end
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
