require_relative 'invoice'
require          'csv'
require          'pry'

class InvoiceRepository
  attr_reader :all, :invoices

  def initialize(csv_hash)
    @invoices = csv_hash.map {|csv_hash| Invoice.new(csv_hash)}
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    invoices
  end

  def find_by_id(invoice_id)
    invoices.find { |invoice| invoice.id == invoice_id.to_i}
  end

  def find_all_by_customer_id

  end

  def find_all_by_merchant_id

  end

  def find_all_by_status

  end

end
