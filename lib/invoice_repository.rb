# frozen_string_literal: true

require 'csv'
require_relative 'invoice'

# Defines Invoice Repository
class InvoiceRepository
  def initialize(filename)
    @invoices = []
    load_invoices(filename)
  end

  def load_invoices(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data)
    end
  end

  def all
    @invoices
  end
end
