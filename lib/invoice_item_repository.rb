require 'csv'

class InvoiceItemRepository
  def initialize(path)
    @path = path
    @rows = CSV.read(@path, headers: true, header_converters: :symbol)
    @all = all
  end

  def all
    result = @rows.map do |row|
      InvoiceItem.new(row)
    end
  end
end
