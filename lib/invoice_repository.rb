class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end 

  def all 
    @invoices
  end 

  def find_by_id(id)
    @invoices.each do |invoice|
      if invoice.id == id
        return invoice
      else
        nil
      end
    end
  end 
end 