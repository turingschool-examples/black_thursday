class InvoiceRepository
  attr_reader :invoices

  def initialize(filename)
    @invoices = create_invoices(filename)
  end

  def create_invoies(filename)
    FileIo.process_csv(filename, Invoice)
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end
end
