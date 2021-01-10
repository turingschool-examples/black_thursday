
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

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  

  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end
end
