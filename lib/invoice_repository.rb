class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end 

  def all 
    @invoices
  end 

end 