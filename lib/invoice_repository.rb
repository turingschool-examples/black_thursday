require 'csv'
require_relative 'invoice'
require_relative 'inspector'

class InvoiceRepository
  include Inspector
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new(row)
    end
  end

  def find_by_id(id_search)
    @all.find do |invoice|
      invoice.id == id_search
    end
  end

  def find_all_by_customer_id(customer_id_search)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id_search
    end
  end

  def find_all_by_merchant_id(merchant_id_search)
    @all.find_all do |invoice|
      invoice.merchant_id == merchant_id_search
    end
  end

  def find_all_by_status(status_search)
    @all.find_all do |invoice|
      invoice.status == status_search
    end
  end

  def create(attributes)
    attributes[:id] = 0
    max_id = @all.max do |invoice|
      invoice.id.to_i
    end
    attributes[:id] = max_id.id + 1
    @all << Invoice.new(attributes)
  end

  def update(invoice_id_search, status_update)
    @all.each do |invoice|
      if invoice.id == invoice_id_search
        invoice.status = status_update[:status]
        invoice.updated_at = Time.now
      end
    end
  end

  def delete(invoice_id_search)
    @all.each do |invoice|
      if invoice.id == invoice_id_search
        @all.delete(invoice)
      end
    end
  end
end
