class InvoiceRepository
  attr_reader :all

  def initialize(invoice_data)
    @all = fill_invoices(invoice_data)
  end

  def fill_invoices(invoice_data)
    all_invoices = CSV.parse(File.read(invoice_data))
    categories = all_invoices.shift
    all_invoices.map do |invoice|
      individual_invoice = {}
      categories.zip(invoice) do |category, attribute|
        individual_invoice[category.to_sym] = attribute
      end
      Invoice.new(individual_invoice)
    end
  end
end
