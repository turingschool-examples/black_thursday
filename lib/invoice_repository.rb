require 'csv'
require_relative 'invoice'
require_relative 'csv_loader'
require_relative 'search'


class InvoiceRepository
  include CsvLoader
  include Search

  attr_reader :invoices

  def initialize(csv_file_path, engine)
    @invoices = create_items(csv_file_path, engine)
    @engine = engine
    return self
  end

  def create_items(csv_file_path, engine)
    create_instances(csv_file_path, 'Invoice', engine)
  end

  def all
    @invoices
  end

  def find_by_id(id_number)
    find_instance_by_id(@invoices, id_number)
  end

  def find_all_by_merchant_id(search_merchant_id)
    find_all_instances_by_merchant_id(@invoices, search_merchant_id)
  end

  def find_all_by_customer_id(search_customer_id)
    search_customer_id = search_customer_id.to_i
    @invoices.find_all do |invoice|
      invoice.customer_id == search_customer_id
    end
  end

  def find_all_by_status(search_status)
    search_status = search_status.downcase
    @invoices.find_all do |invoice|
      invoice.status == search_status
    end
  end
end
