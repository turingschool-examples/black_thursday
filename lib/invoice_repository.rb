require 'csv'
require_relative '../lib/invoice'
require_relative '../lib/csv_parser'
require 'pry'

class InvoiceRepository

  include CsvParser

  attr_reader :invoices,
              :se

  def initialize(csv_file, se)
    @invoices = []
    @se = se
    parser(csv_file).each { |row| @invoices << Invoice.new(row, self) }
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def all
    @invoices
  end

  def items(invoice_id)
    se.invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def transactions(invoice_id)
    se.transactions.find_all_by_invoice_id(invoice_id)
  end

  def customer(customer_id)
    se.customers.find_by_id(customer_id)
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

  def find_all_by_invoice_id(id)
    @invoices.find_all do |id_num|
      id_num.id.to_i == id
    end
  end

  def find_all_by_status(status_input)
    @invoices.find_all do |num|
      num.status == status_input
    end
  end

  def find_merchant_by_merchant_id(merchant_id)
    se.find_merchant_by_id(merchant_id)
  end


  def grab_array_of_invoices
    merchants.map { |merchant| merchant.invoices.count }
  end

  def find_item_by_id(item_id)
    se.items.find_by_id(item_id)
  end

  def grab_all_items
    se.items.all
  end

end
