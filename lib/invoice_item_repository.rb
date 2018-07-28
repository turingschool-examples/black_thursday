# frozen_string_literal: true

require_relative './invoice_item'
require 'bigdecimal'
require 'time'

# InvoiceItemRepository class
class InvoiceItemRepository
  def initialize
    @invoice_items = {}
  end

  def populate(data)
    data.map do |row|
      row[:unit_price] = BigDecimal(row[:unit_price].dup.insert(-3, '.'))
      row[:created_at] = Time.parse(row[:created_at])
      row[:updated_at] = Time.parse(row[:updated_at])
      create(row)
    end
  end

  def create(params)
    params[:id] = @invoice_items.max[0] + 1 if params[:id].nil?

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

  def find_all_by_item_id(id)
    found_invoice_items = @invoice_items.find_all do |_, invoice_item|
      invoice_item.item_id == id
    end.flatten
    found_invoice_items.keep_if do |element|
      element.is_a?(InvoiceItem)
    end
  end

  def find_all_by_invoice_id(id)
    found_invoice_items = @invoice_items.find_all do |_, invoice_item|
      invoice_item.invoice_id == id
    end.flatten
    found_invoice_items.keep_if do |element|
      element.is_a?(InvoiceItem)
    end
  end

  def update(id, params)
    return nil unless @invoice_items.key?(id)
    sig_fig = params[:unit_price].to_s.size - 1

    invoice_item = find_by_id(id)
    invoice_item.quantity = params[:quantity] unless params[:quantity].nil?
    invoice_item.unit_price = BigDecimal(params[:unit_price], sig_fig) unless params[:unit_price].nil?
    invoice_item.updated_at = Time.now
  end

  def delete(id)
    @invoice_items.delete(id)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end
end
