# InvoiceRepo holds, creates, updates, destroys, and finds Invoices.
require './lib/general_repo'

class InvoiceRepo < GeneralRepo
  attr_reader :invoices

  def initialize(data)
    super(data, 'Invoice')
  end

  def find_by_customer_id(id)
    @invoices.select { |invoice| invoice.customer_id == id.to_s }
  end

  def find_by_merchant_id(id)
    @invoices.select { |invoice| invoice.merchant_id == id.to_s }
  end

  def find_all_by_status(status)
    @invoices.select { |invoice| invoice.status == status }
  end
end



