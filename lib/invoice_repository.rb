require 'csv'

class InvoiceRepository

  def initialize(path)
    @path = path
    @row = CSV.read(@path, headers: true, header_converters: :symbol)
  end
end
