class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices_data)
    @invoices = create_invoices(invoices_data)
  end

  def create_items(invoices_data)
    invoices_data.map do |invoice|
      Invoice.new(invoice)
    end
  end

  def all
    @invoices
  end



end
