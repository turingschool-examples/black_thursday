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
end
