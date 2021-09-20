# frozen_string_literal: true
require 'csv'
require_relative './sales_engine'
require_relative './invoices'
#
class InvoiceRepository
  def initialize(data)
    @invoices = data
  end

  def all
    @invoices
  end

  def find_by_id(id)
    invoice_id = nil
    @invoices.select do |invoice|
      if invoice.id == id
        invoice_id = invoice
      end
    end
    invoice_id
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      if invoice.customer_id == id
        invoice
      end
    end
  end
#
  def find_all_by_merchant_id(id)
    @invoices.find_all do |invoice|
      if invoice.merchant_id == id
        invoice
      end
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      if invoice.status.downcase == status.downcase
        invoice
      end
    end
  end

  def highest_id
    new = @invoices.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_invoice = Invoice.new([highest_id, attributes[:customer_id], attributes[:merchant_id], attributes[:status], Time.now.strftime('%Y-%m-%d'), Time.now.strftime('%Y-%m-%d')])
      @invoices << new_invoice
  end

  def update(id, attributes)
    @invoices.map do |invoice|
      if invoice.id == id
        invoice.status = attributes[:status]
        invoice.updated_at = Time.now
      end
    end
  end

  def delete(id)
    trash = @invoices.find do |invoice|
      invoice.id == id
    end
    @invoices.delete(trash)
  end
end
