class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices, parent)
    @invoices = invoices.map {|invoice| Invoice.new(invoice)}
    @parent = parent
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id.downcase == id.downcase
    end
  end

  def find_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id.downcase == customer_id.downcase
    end
  end

  def find_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id.downcase == merchant_id.downcase
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status.downcase == status.downcase
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
