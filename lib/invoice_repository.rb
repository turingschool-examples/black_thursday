require_relative 'invoice'
class InvoiceRepository


  def initialize(data)
    @invoices = []
      CSV.foreach(data, headers: true, header_converters: :symbol) do |row| header ||= row.headers
        @invoices << Invoice.new(row)
    end
  end

  def all
    @invoices
  end


end
