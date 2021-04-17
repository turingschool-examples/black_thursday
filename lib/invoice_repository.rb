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



end
