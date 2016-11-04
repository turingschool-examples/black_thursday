require_relative 'invoice'
require 'csv'
require 'bigdecimal'

class InvoiceRepository
  attr_reader   :contents,
                :invoices,
                :parent

  def initialize(path, parent = nil)
    @contents = CSV.open path, headers: true, header_converters: :symbol
    @parent = parent
    @invoices = contents.map do |line|
      Invoice.new(line, self)
    end
  end

  def all
    invoices
  end

  def find_by_id(id_number)
    invoices.find do |invoice|
      invoice.id == id_number
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_merchant(merchant_id)
    parent.find_merchant(merchant_id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

end