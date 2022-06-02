require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({
        :id => row[:id],
        :customer_id => row[:customer_id],
        :merchant_id => row[:merchant_id],
        :status => row[:status],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        })
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

  end

  def update(invoice_id_search, status_update)
    @all.find do |invoice|
      invoice.id == invoice_id_search
      invoice.status = status_update
    end
  end

  def delete(invoice_id_search)
    @all.find do |invoice|
      invoice.id == invoice_id_search
      @all.delete(invoice)
    end
  end
end
