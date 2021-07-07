require_relative 'invoice'

# This is the invoice repository class
class InvoiceRepository
  attr_reader :parent, :invoices
  def initialize(invoice_csv, parent)
    @parent = parent
    @invoices = []

    csv_file = CSV.open(invoice_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == status }
  end

  def find_all_by_date(date)
    @invoices.find_all { |invoice| invoice.created_at == date }
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
