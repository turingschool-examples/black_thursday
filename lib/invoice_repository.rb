require_relative 'invoice'

class InvoiceRepository

  attr_reader :all

  def initialize(invoices)
    @all = invoices
  end

end