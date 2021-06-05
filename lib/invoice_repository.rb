require 'csv'
require_relative 'invoice'

class InvoiceRepository

  def initialize
    @all = []
    create_invoice(path)
  end

end
