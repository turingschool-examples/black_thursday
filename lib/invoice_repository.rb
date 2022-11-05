require 'csv'
require_relative './invoice'
require 'pry'

class InvoiceRepository
    attr_reader :invoice_repo

  def initialize
    @invoice_repo = []
  end

  def create(attributes)
    unless invoice_repo.empty?
    attributes[:id] = all.max do |invoice|
      invoice.id
      end.id + 1
    end
    new_invoice = Invoice.new(attributes)
    @invoice_repo << new_invoice
    new_invoice
  end

  def inspect
    "#<#{self.class} #{@invioce_repo.size} rows>"
  end
end