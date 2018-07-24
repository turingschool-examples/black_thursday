require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require_relative 'repository'

class InvoiceRepository
  include Repository

  def initialize(invoices)
    @list = invoices
  end

end
