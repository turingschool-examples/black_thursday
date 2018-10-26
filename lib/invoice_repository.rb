require 'time'
require_relative '../lib/invoice'
require_relative '../lib/repository'

class InvoiceRepository
  include Repository

  def initialize(invoices)
    @collection = invoices
  end

  #I need
  #all
  #find_by_id
  #find_all_by_customer_id
  #find_all_by_merchant_id
  #find_all_by_status
  #create(attributes) Takes id and invoice)
  #update(id, attributes)
  #delete(id)

end
