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
end
