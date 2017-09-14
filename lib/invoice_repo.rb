require_relative 'invoice'
require 'csv'

class InvoiceRepo
  attr_reader :all_invoices, :parent
  def initialize(file, se = nil)
    @all_invoices = []
    open_file(file)
<<<<<<< HEAD
=======
    @parent = se
>>>>>>> d9ec84da501d47a25cbe6a5f36cc2c6d6a854ee8
  end

  def open_file(file)
    CSV.foreach file, headers: true, header_converters: :symbol do |row|
      all_invoices << Invoice.new(row, self)
    end
  end

  def all
    @all_invoices
  end

  def find_by_id(invoice_id)
    all_invoices.find { |invoice| invoice.id == invoice_id }
  end

  def find_all_by_customer_id(customer_id)
    all_invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    all_invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    all_invoices.find_all { |invoice| invoice.status == status.to_sym}
  end

end
