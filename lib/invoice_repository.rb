class InvoiceRepository
  attr_reader :path,
              :invoices

  def initialize(path)
    @path = path
    @invoices = []
    read_invoice
  end

  def read_invoice
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row)
    end

    @invoices
  end
end
