require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoice_data, :all, :parent

  def initialize(invoice_data, parent = nil)
    @invoice_data = invoice_data
    @all = invoice_data.map { |row| Invoice.new(row, self) }
    @parent = parent
  end

  def find_by_id(id)
    all.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(customer_id)
    @all.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @all.select { |invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    status = status.to_sym
    all.select { |invoice|
      invoice.status == status }
  end

  def merchant(invoice_id)
    invoice = find_by_id(invoice_id)
    binding.pry

  end

  def inspect
    binding.pry
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
