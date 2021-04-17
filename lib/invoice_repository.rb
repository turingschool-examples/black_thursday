require_relative '../lib/invoice'
require_relative '../lib/repository'

class InvoiceRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_invoices(@parsed_csv_data)
  end

  def create_invoices(parsed_csv_data)
    parsed_csv_data.map do |invoice|
      Invoice.new(invoice)
    end
  end

  def create(attributes)
    max_id = @array_of_objects.max_by do |invoice|
      invoice.id
    end.id
  
    new_invoice = Invoice.new(attributes)
    new_invoice.id = max_id + 1
    @array_of_objects << new_invoice
  end


end
