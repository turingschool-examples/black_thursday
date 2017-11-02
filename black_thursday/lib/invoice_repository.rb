class InvoiceRepository
  attr_reader :invoices,
              :parent

  def initialize(invoices, parent = nil)
    @invoices  = load_csv(invoices).map { |row| Invoice.new(row, self) }
    @parent = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_merchant_id(merchant_id)
    return [] if merchant_id.nil?
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end
end
