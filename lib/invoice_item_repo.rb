require 'csv'
require_relative 'invoice_item'
class InvoiceItemRepo

  attr_reader :all_invoices, :parent

  def initialize(file, se=nil)
    @all_invoices = []
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_invoices << InvoiceItem.new(row, self)
    end
  end

  def all
    @all_invoices
  end

  def find_by_id(invoice_id)
    all_invoices.find {|invoice| invoice.id == invoice_id }
  end

  def find_all_by_item_id(item_id)
    all_invoices.find_all do |invoice|
      invoice.item_id == item_id
    end
  end

  def find_all_by_invoice_id(id)
    all = all_invoices.find_all do |invoice|
      invoice.invoice_id == id
    end
  end

end
