require 'csv'
require_relative '../lib/invoice_item'
require_relative '../lib/file_opener'

class InvoiceItemRepository
  include FileOpener
  attr_reader :sales_engine,
              :all_invoice_item_data

  def initialize(data_files, sales_engine)
    @sales_engine = sales_engine
    all_invoice_items = open_csv(data_files)
    @all_invoice_item_data = all_invoice_items.map{|row| InvoiceItem.new(row, self)}
  end

  def all
    @all_invoice_item_data
  end

  def find_by_id

  end

  def find_all_by_item_id

  end

  def find_all_by_invoice_id

  end
end
