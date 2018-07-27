# frozen_string_literal: true

require_relative './invoice'
require 'time'
require 'pry'

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

  def populate(data)
    data.map do |row|
      row[:created_at] = Time.parse(row[:created_at].to_s)
      row[:updated_at] = Time.parse(row[:updated_at].to_s)
      create(row)
    end
  end

  def all
    invoice_pairs = @invoices.to_a.flatten
    invoice_pairs.keep_if do |element|
      element.is_a?(Invoice)
    end
  end

  def find_by_id(id)
    @invoices.fetch(id)
  end

  def find_all_by_customer_id(id)
    found_invoices = @invoices.find_all do |_, invoice|
      invoice.customer_id == id
    end.flatten
    found_invoices.keep_if do |element|
      element.is_a?(Invoice)
    end
  end

  def find_all_by_merchant_id(id)
    found_invoices = @invoices.find_all do |_, invoice|
      invoice.merchant_id == id
    end.flatten
    found_invoices.keep_if do |element|
      element.is_a?(Invoice)
    end
  end

  def find_all_by_status(status)
    found_invoices = @invoices.find_all do |_, invoice|
      invoice.status == status
    end.flatten
    found_invoices.keep_if do |element|
      element.is_a?(Invoice)
    end
  end

  def update(id, params)
    return nil unless @invoices.key?(id)
    invoice = find_by_id(id)
    invoice.status = params[:status] unless params[:status].nil?
    invoice.updated_at = Time.now
  end

  def delete(id)
    @invoices.delete(id)
  end

end
