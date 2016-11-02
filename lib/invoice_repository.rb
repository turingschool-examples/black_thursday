require_relative 'invoice'

class InvoiceRepository

  attr_reader :all

  def initialize(invoices)
    @all = invoices
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end