require_relative 'invoice'

class InvoiceRepository
  attr_accessor :all
  
  def initialize(file_path, parent=nil)
    @all    = csv_parse(file_path).map {|row| Invoice.new(row, self)}
    @parent = parent
  end

  def csv_parse(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end
  
  def inspect
    "#{self.class}"
  end
end