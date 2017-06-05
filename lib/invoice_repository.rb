require 'pry'
require 'csv'
require_relative 'invoice'


class InvoiceRepository

  attr_reader :all

  def initialize(file_path, parent = nil)
    @parent = parent
    @all = []
    populate_invoices(file_path)
  end

  def populate_invoices(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Invoice.new(line, self)
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def mid_to_se(merchant_id)
    @parent.merchant_by_merchant_id(merchant_id)
  end

  def invoice_id_to_se(invoice_id)
    @parent.items_by_invoice_id(invoice_id)
  end

  def inspect
   "#<#{self.class} #{@all.size} rows>"
  end

end
