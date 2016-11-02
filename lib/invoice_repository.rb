require_relative 'invoice'

class InvoiceRepository

  attr_reader :all

  def initialize(invoices)
    @all = invoices
  end

  def find_by_id(id)
    all.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    all.find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.find_all {|invoice| invoice.status == status}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end