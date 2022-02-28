class InvoiceRepository
  attr_reader :invoices_instances_array
  def initialize(invoices_instances_array)
    @invoices_instances_array = invoices_instances_array
  end

  def all
    invoices_instances_array
  end

  def find_by_id(id)
    invoices_instances_array.find do |invoice_instance|
      invoice_instance.invoice_attributes[:id] == id
    end
  end
end
