require_relative '../lib/invoice'

class InvoiceRepository
  attr_reader :list_of_invoices,
              :parent_engine

  def initialize(invoices_data, parent_engine)
    @parent_engine = parent_engine
    @list_of_invoices = populate_invoices(invoices_data)
  end

  def populate_invoices(invoices_data)
    invoices_data.map do |datum|
      Invoice.new(datum, self)
    end
  end

  def all
    list_of_invoices
  end

end
