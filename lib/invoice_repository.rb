# frozen_string_literal: true

require_relative './invoice'

# Invoice repository class
class InvoiceRepository
  def initialize
    @invoices = {}
  end

  def create(params)
    params[:id] = @invoices.max[0] + 1 if params[:id].nil?

    Invoice.new(params).tap do |invoice|
      @invoices[params[:id].to_i] = invoice
    end
  end

  def all
    invoice_pairs = @invoices.to_a.flatten
    invoice_pairs.keep_if do |element|
      element.is_a?(Invoice)
    end
  end
end
