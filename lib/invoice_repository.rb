require_relative 'invoice'
require_relative 'repository'

class InvoiceRepository < Repository
  def initialize
    @type = Invoice
    @attr_whitelist = [:status]
    super
  end

  def find_all_by_customer_id(id)
    @instances.find_all {|invoice| invoice.customer_id == id}
  end
end
