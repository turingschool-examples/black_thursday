require 'csv'

class InvoiceRepository

  def initialize(path)
    @path = path
    @rows = CSV.read(@path, headers: true, header_converters: :symbol)
    @all = all
  end

  def all
    @rows.map do |row|
      Invoice.new(row)
    end
  end
end
