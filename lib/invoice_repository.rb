require 'csv'
require_relative '../lib/invoice'
require_relative '../lib/csv_parser'

class InvoiceRepository

  include CsvParser

  attr_reader :invoices,
              :se

  def initialize(csv_file, se)
    @invoices = []
    @se = se
    parser(csv_file).each { |row| @invoices << Invoice.creator(row, self) }
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |id_num|
      id_num.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |id_num|
      id_num.customer_id.to_i == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all do |id_num|
      id_num.merchant_id.to_i == id
    end
  end

  def find_all_by_status(status_input)
    @invoices.find_all do |num|
      num.status == status_input
    end
  end

  def find_merchant_by_invoice(id)
    se.merchant_by_invoice_id(id)
  end

  #BI
  def grab_array_of_invoices # NEEDS TESTS || Returns array of invoice count per merchant
    merchants.map { |merchant| merchant.invoices.count }
  end

end
