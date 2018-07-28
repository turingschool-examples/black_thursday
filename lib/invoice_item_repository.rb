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

  def all
    invoice_item_pairs = @invoice_items.to_a.flatten
    invoice_item_pairs.keep_if do |element|
      element.is_a?(InvoiceItem)
    end
  end

  def find_by_id(id)
    return nil unless @invoice_items.key?(id)
    @invoice_items.fetch(id)
  end

end
