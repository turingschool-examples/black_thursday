# frozen_string_literal: true

require_relative './invoice_item'
require 'bigdecimal'
require 'time'

#InvoiceItemRepository class
class InvoiceItemRepository
  def initialize
    @invoice_items = {}
  end

  def create(params)
    params[:id] - @invoices.max[0] + 1 if params[:id].nil?

    InvoiceItem.new(params).tap do |invoice_item|
      @invoice_items[params[:id].to_i] = invoice_item
    end
  end
end
