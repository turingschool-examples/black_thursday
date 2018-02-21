require 'time'
require 'bigdecimal'
require_relative '../lib/invoice'

# class for invoices
class InvoiceRepository
  def initialize(filepath, parent)
    @invoices = []
    @parent = parent
    load_invoices(filepath)
  end

  def all
    @invoices
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

end
