class InvoiceRepo
  attr_reader :all

  def initialize(csv_data, engine)
    create_invoices(csv_data)
    @engine = engine
  end

  def find_by_id(id)

  end

  def create_invoices(csv_data)
    invoices = CSV.open(csv_data, headers: true,
    header_converters: :symbol)

    @all = invoices.map do |invoice|
      Invoice.new(invoice)
    end
  end

end
