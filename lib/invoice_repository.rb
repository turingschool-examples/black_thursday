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
    new_id = 0
    @all.each do |invoice|
      if invoice.id.to_i >= new_id
        new_id = invoice.id.to_i + 1
      end
    end
    @all << Invoice.new( {
      :id => new_id.to_i,
      :customer_id => attributes[:customer_id].to_i,
      :merchant_id => attributes[:merchant_id].to_i,
      :status => attributes[:status].to_sym,
      :created_at => Time.parse(attributes[:created_at].to_s),
      :updated_at => Time.parse(attributes[:updated_at].to_s)
      } )
  end

  def update(invoice_id_search, status_update)
    @all.find do |invoice|
      if invoice.id == invoice_id_search
        invoice.status = status_update
        invoice.updated_at = Time.now
      end
    end
  end

  def delete(invoice_id_search)
    @all.find do |invoice|
      invoice.id == invoice_id_search
      @all.delete(invoice)
    end
  end
end
