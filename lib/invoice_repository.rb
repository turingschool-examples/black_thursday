require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'repository'

class InvoiceRepository
  include Repository

  def initialize(invoices)
    @list = invoices
  end

  def find_all_by_customer_id(id)
    @list.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_status(status)
    @list.find_all do |invoice|
      invoice.status == status
    end
  end
  
end
