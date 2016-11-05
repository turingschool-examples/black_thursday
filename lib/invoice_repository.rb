require_relative 'invoice'
require 'pry'

class InvoiceRepository
  attr_reader   :invoice,
                :parent,
                :all

  def initialize(invoice_data, parent = nil)
    @parent = parent
    @all = []
    populate(invoice_data)
  end

  def populate(invoice_data)
    invoice_data.each do |invoice|
      @all << Invoice.new(invoice, self)
    end
  end

end