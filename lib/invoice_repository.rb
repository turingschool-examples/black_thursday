# frozen_string_literal: true

require_relative './invoice'
require_relative './repository_helper'

# Invoice repository class
class InvoiceRepository
  include RepositoryHelper

  def initialize
    @invoices = {}
  end

  def create(params)
    params[:id] = @invoices.max[0] + 1 if params[:id].nil?

    Invoice.new(params).tap do |invoice|
      @invoices[params[:id].to_i] = invoice
    end
  end

  def update(id, params)
    return nil unless @invoices.key?(id)
    invoice = find_by_id(id)
    invoice.status = params[:status] unless params[:status].nil?
    invoice.updated_at = Time.now
  end

  def all
    invoice_pairs = @invoices.to_a.flatten
    remove_keys(invoice_pairs, Invoice)
  end

  def find_by_id(id)
    return nil unless @invoices.key?(id)
    @invoices.fetch(id)
  end

  def find_all_by_customer_id(id)
    found_invoices = @invoices.find_all do |_, invoice|
      invoice.customer_id == id
    end.flatten
    remove_keys(found_invoices, Invoice)
  end

  def find_all_by_merchant_id(id)
    found_invoices = @invoices.find_all do |_, invoice|
      invoice.merchant_id == id
    end.flatten
    remove_keys(found_invoices, Invoice)
  end

  def find_all_by_status(status)
    found_invoices = @invoices.find_all do |_, invoice|
      invoice.status == status
    end.flatten
    remove_keys(found_invoices, Invoice)
  end

  def delete(id)
    @invoices.delete(id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
