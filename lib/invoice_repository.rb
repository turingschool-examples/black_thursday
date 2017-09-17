require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository

  def record_class
    Invoice
  end

  def find_all_by_customer_id(customer_id)
    find_all {|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    find_all {|invoice| invoice.status == status}
  end

end
