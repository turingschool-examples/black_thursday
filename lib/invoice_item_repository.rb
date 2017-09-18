require 'csv'
require_relative 'invoice_item'
require_relative 'csv_loader'
require_relative 'search'


class InvoiceItemRepository
  include CsvLoader
  include Search

  attr_reader :invoices

  def initialize(csv_file_path, engine)
    @invoice_items = create_items(csv_file_path, engine)
    @engine = engine
    return self
  end

  def create_items(csv_file_path, engine)
    create_instances(csv_file_path, 'InvoiceItem', engine)
  end

  def all
    @invoice_items
  end

  def find_by_id(id_number)
    find_instance_by_id(@invoice_items, id_number)
  end

  def find_all_by_item_id(search_item_id)
    search_item_id = search_item_id.to_i
    @invoice_items.find_all do |invoice_item|
      invoice_item.item_id == search_item_id
    end
  end

  def find_all_by_invoice_id(search_invoice_id)
    find_all_instances_by_invoice_id(@invoice_items, search_invoice_id)
  end

end
