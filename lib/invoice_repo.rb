class InvoiceRepo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def to_array
    invoices = []

    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      headers = row.headers
      invoices << row.to_h
    end
    invoices.map do | item |
      Invoice.new(item)
    end
  end

  def find_by_id(id)
    all.find do |invoice|
      invoice.id == id
    end
  end

end
