# InvoiceRepo holds, creates, updates, destroys, and finds repository.
require './lib/general_repo'

class InvoiceRepo < GeneralRepo
  
  def initialize(data)
    super('Invoice', data)
  end

  def find_by_customer_id(id)
    @repository.select { |invoice| invoice.customer_id == id.to_s }
  end

  def find_by_merchant_id(id)
    @repository.select { |invoice| invoice.merchant_id == id.to_s }
  end

  def find_all_by_status(status)
    @repository.select { |invoice| invoice.status == status }
  end
end



