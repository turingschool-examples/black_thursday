require_relative '../lib/invoice'
require_relative '../lib/repository_helper'
require 'csv'

class InvoiceRepository
  include RepositoryHelper
  attr_reader :all,
              :invoices

  def initialize(filepath)
    @filepath = filepath
    @invoices = []
    @all = []
  end

  def create_invoices
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(row)
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    id = create_id
    invoice = Invoice.new({
      id: id,
      customer_id: attributes[:customer_id],
      merchant_id: attributes[:merchant_id],
      status: attributes[:status],
      created_at: Time.now,
      updated_at: Time.now}
      )
      @all << invoice
      invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return if invoice.nil?
    invoice.status = attributes[:status]
    invoice.updated_at = Time.now
    invoice
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
