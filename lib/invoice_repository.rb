require_relative 'invoice'

class InvoiceRepository

  attr_reader     :all

  def initialize
    @all = []
  end

  def populate(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(row, self)
    end
  end

  
end
