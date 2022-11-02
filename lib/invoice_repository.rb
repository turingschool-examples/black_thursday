require_relative 'find'
require_relative 'modify'

class InvoiceRepository
  include Find
  include Modify

  attr_reader :invoices
  def initialize
    @invoices = []
  end

  def add(invoice)
    @invoices << Invoice.new(invoice)
  end
end